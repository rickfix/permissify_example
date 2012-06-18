class CorporationUsersController < UsersController
  def domain_users_path
    corporation_corporation_users_path(@current_entity)
  end
  
  def set_nav
    @active_tab = 'corporations'
    @active_section = 'Corporation Admin'
    @active_nav = 'Corporation Users'
    @domain_type = 'Corporation'
    @domain_category = :corporation_users
    @entity_key = :corporation_id
    @entity_association = :corporations
  end
end
