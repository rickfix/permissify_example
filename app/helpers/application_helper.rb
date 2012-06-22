module ApplicationHelper
  def format_notification note, type="success",optionclass = ''
    return "" if note.blank?
    html=<<-END
       <div id="#{type}Explanation" class="feedback">
        <h2 style="#{optionclass}">#{note}</h2>
      </div>
    END
  end
  
  def current_user_can_manage?(user)
    (current_user.roles.collect{|r| r.manages}.flatten & user.roles).collect(&:id).sort == user.roles.collect(&:id).sort
  end
  
  def current_user_edit_path
    send("edit_#{current_user.primary_domain_type.downcase}_user_path", (@current_entity || @entity).id, current_user.id)
  end
  
  def inactive_nav_items
    items = Ability.all.collect{|a| a[:category] if a[:section] == @active_section}.compact.uniq +
            ['eGift', 'Guest Management', 'Loyalty', 'Marketing Engine', 'Online Ordering', 'Webpage Builder']
    items.delete(@active_nav_text)
    items
  end
  
  def permission_category_for(nav_item)
    nav_item.downcase.gsub('-','_').gsub(':','').gsub('  ',' ').gsub(' ','_')
  end
  
  NAVIGATION_COMBOBULATOR = {
    'Roles' => [:roles_path, :non_entity_path],
    'Products' => [:products_path, :non_entity_path],

    'Admin Users' => [:admin_users_path, :non_entity_path, 'Users'],

    'Dealers' => [:dealer_path, :entity_id_path, 'Account'],
    'Dealer Users' => [:dealer_users_path, :entity_id_path, 'Users'],

    'Corporations' => [:corporation_path, :entity_id_path, 'Account'],
    'Corporation Users' => [:corporation_users_path, :entity_id_path, 'Users'],
    'Corporation Products' => [:entity_products_path, :entity_path, 'Products'],

    'Brands' => [:brand_path, :entity_id_path, 'Account'],
    'Brand Users' => [:brand_users_path, :entity_id_path, 'Users'],
    'Brand Products' => [:entity_products_path, :entity_path, 'Products'],

    'Merchants' => [:merchant_path, :entity_id_path, 'Account'],
    'Merchant Users' => [:merchant_users_path, :entity_id_path, 'Users'],
    'Merchant Products' => [:entity_products_path, :entity_path, 'Products'],
    
    'eGift' => [:egift_path, :entity_path],
    'Guest Management' => [:guest_management_path, :entity_path],
    'Loyalty' => [:loyalty_path, :entity_path],
    'Marketing Engine' => [:marketing_engine_path, :entity_path],
    'Online Ordering' => [:online_ordering_path, :entity_path],
    'Webpage Builder' => [:webpage_builder_path, :entity_path],
  }
  
  def nav_link_href_and_text_for(nav_token)
    path_method, path_generation_method, nav_text = NAVIGATION_COMBOBULATOR[nav_token]
    return if path_method.nil?
    [send(path_generation_method, path_method, (@current_entity || @entity)), nav_text || nav_token]
  end
  
  def entity_path(path_method, entity)
    send(path_method, entity.class.name, entity.id)
  end
  
  def entity_id_path(path_method, entity)
    send(path_method, entity.id)
  end
  
  def non_entity_path(path_method, entity)
    send(path_method)
  end
  
  def categorized_entity_url(e, hierarchy_tag, entity_category_path = @entity_category_path)
    if entity_category_path
      @is_entity_path == true ?
        send(entity_category_path.sub(@entity_name, hierarchy_tag), hierarchy_tag, e) :
        send(entity_category_path.sub(@entity_name, hierarchy_tag), e.id)
    else
      send("#{hierarchy_tag.downcase}_path", e.id)
    end
  end

  def sorted_inactive_nav_items
    @nav_list = {}
    inactive_nav_items.each do |nav_item|
      item = render(:partial => 'layouts/nav_item', :collection => [nav_item])
      @nav_list[@nav_tag] = item
    end
    @nav_list.keys.compact.sort{|k1,k2| k1.downcase <=> k2.downcase}
  end
  
  def permissible_nav_item(nav_item)
    category = permission_category_for(nav_item)
    allowed_to?(:view, category) || subscribed_to?(category)
  end
end
