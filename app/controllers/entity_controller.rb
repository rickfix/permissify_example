class EntityController < ApplicationController
  before_filter :require_user
  before_filter :set_nav
  before_filter :derive_entity_type_values
  before_filter :set_other_entity_stuff
  before_filter :find_entity_by_id, :only => [:show, :destroy]
  before_filter :find_entity_by_entity_id, :only => [:index, :update_dealer, :update_corporation, :update_brand]

  def index
    @current_entity ||= current_user.entity
    @entity_list = @current_entity ? @current_entity.send(@entity_name.pluralize) : current_user.entity.send(@entity_name.pluralize) # .all
    @active_section = nil
    @create_path = send("new_#{@entity_name}_path")
    @add_label = "new #{@entity_name}"
  end

  def destroy
    @entity.respond_to?(:deleted_at) ? @entity.update_attribute(:deleted_at, Time.now) : @entity.destroy
  end
  
  def show
  end
  
  def create
    @entity = @permissions_object = @entity_class.new
    @entity.name = (entity_params = params[@entity_name])[:name]
    @entity.ancestors.each{ |ancestor| @entity.send("#{ancestor}_id=", entity_params["#{ancestor}_id"]) }
    @entity.save
    @response_message = @entity.errors.full_messages.join(', ')
  end
  
  def update_dealer
    @dealer = find_entity_by_id
    @corporation = (@dealer.corporations.first rescue nil)
    complete_entity_association_update
  end
  
  def update_corporation
    @corporation = find_entity_by_id
    @dealer = @corporation.dealer
    complete_entity_association_update
  end
  
  def update_brand
    @brand = find_entity_by_id
    @corporation = @brand.corporation
    @dealer = @brand.dealer
    complete_entity_association_update
  end
  
  def complete_entity_association_update
    @brand ||= (@corporation.brands.first rescue nil)
    @current_entity.dealer = @dealer if @dealer
    @current_entity.corporation = @corporation if @corporation
    @current_entity.brand = @brand if @brand
    @current_entity.save
    # when corp changes dealers, all of its brands and merchants need to be updated with new dealer id
    # when brand changes dealers, all of its merchants should be updated with new dealer and defaulted corp id
    # when brand changes corps, all of its merchants should be updated with new corp id and (possibly changed) dealer id
    redirect_to "/#{@current_entity.class.name.downcase}s/#{@current_entity.id}"
  end
  
  def set_other_entity_stuff
    @entity_name = @entity_class.name.downcase
  end
  
  def find_entity_by_id
    @entity = current_user.entity.send(@entity_class.name.downcase.pluralize).select{ |e| e.id == params[:id].to_i }.first
    @current_entity ||= @entity
    logger.debug("*** find_entity_by_id: #{@entity.inspect}"); @entity
  end

  def find_entity_by_entity_id
    @current_user_entity = current_user.entity
    return unless (entity_type = params[:entity_type])
    entities = @current_user_entity.send(entity_type.downcase.pluralize)
    @current_entity = @entity = entities.select{ |e| e.id == params[:entity_id].to_i }.first
    logger.debug("*** find_entity_by_entity_id: #{@current_entity.inspect}"); @current_entity
  end

  def set_nav # a whole lot of name coupling...
    @entity_type = self.class::ENTITY_TYPE
    @entity_category_path = "#{@entity_type.downcase}_path"
    @active_nav_text = 'Account'
    @domain_category = "#{@entity_type.downcase.to_sym}_admin".to_sym
    @active_nav = @entity_type.titleize.pluralize
  end

end
