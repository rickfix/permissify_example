module UsersHelper
  def form_locals(title, path = send(domain_path, @current_entity.id, @user.id), method = :put)
    {:title => title, :path => path, :method => method}
  end

  def domain_roles_that_current_user_can_manage
    @manageable_domain_roles ||= (@current_user.roles.collect(&:manages).flatten.uniq & @domain_roles)
  end
  
  def new_domain_users_path
    send("new_#{domain_path}", @current_entity.id)
  end
  
  def domain_user_path(user)
    send("#{domain_path}", @current_entity.id, user.id)
  end
  
  def edit_domain_user_path(user)
    send("edit_#{domain_path}", @current_entity.id, user.id)
  end
  
  def domain_path
    "#{@entity_type.downcase}_user_path"
  end
end
