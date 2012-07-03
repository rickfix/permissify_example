class EntityProductsController < ApplicationController
  before_filter :require_user
  before_filter :set_nav
  before_filter :derive_entity_type_values

  def index
    @current_user_entity = current_user.entity
    entities = @current_user_entity.send(@entity_type.downcase.pluralize)
    @current_entity = @entity = entities.select{ |e| e.id == @entity_id.to_i }.first
    @entity_list = @current_entity.send(@entity_association)
  end

  def update
    @current_entity = current_user.entity.send(@entity_association).select{ |e| e.id == @entity_id.to_i }.first
    @product = Product.find_by_id(@product_id = params[:id])
    if (@on_or_off = params[:on_or_off]) == '1'
      @current_entity.products += [@product]
      @response_class = 'addedProduct'
    else
      @current_entity.products -= [@product]
      @response_class = 'removedProduct'
    end
  end

  private
  
  def set_nav # a whole lot of name coupling...
    @entity_type = params[:entity_type]
    @entity_id = params[:entity_id]
    @entity_category_path = "entity_products_path"
    @entity_base_route = ''
    @is_entity_path = true
    @active_nav_text = 'Products'
  end

end
