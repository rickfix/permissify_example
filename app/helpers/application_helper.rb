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
    send("edit_#{current_user.primary_domain_type.downcase}_#{current_user.primary_domain_type.downcase}_user_path", (@current_entity || @entity).id, current_user.id)
  end
  
  def entity_path_and_nav_label_for(nav_token)
    entity_id = (@current_entity || @entity).id
    path_method, tag, is_entity_path = {
      # 'Admin Users' => [admin_users_path(entity.id), 'Users'],
      'Corporation Products' => [:entity_products_path, 'Products', true],
      'Brand Products' => [:entity_products_path, 'Products', true],
      'Merchant Products' => [:entity_products_path, 'Products', true],
      'Dealer Users' => [:dealer_users_path, 'Users'],
      'Corporation Users' => [:corporation_users_path, 'Users'],
      'Brand Users' => [:brand_users_path, 'Users'],
      'Merchant Users' => [:merchant_users_path, 'Users']
    }[nav_token]
    return if path_method.nil?
    [is_entity_path ? send(path_method, (@current_entity || @entity).class.name, entity_id) : send(path_method, entity_id), tag]
    # TODO : prefer something like: [entity_users_path, 'Users']
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
end
