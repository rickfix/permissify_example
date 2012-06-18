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
    path_method, tag = { # 'Admin Users' => [admin_users_path(entity.id), 'Users'],
      'Dealer Users' => [:dealer_dealer_users_path, 'Users'],
      'Corporation Users' => [:corporation_corporation_users_path, 'Users'],
      'Brand Users' => [:brand_brand_users_path, 'Users'],
      'Merchant Users' => [:merchant_merchant_users_path, 'Users']
    }[nav_token]
    return if path_method.nil?
    [send(path_method, entity_id), tag]
    # TODO : prefer something like: [domain_users_path, 'Users']
  end
end
