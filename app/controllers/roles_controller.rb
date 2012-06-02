class RolesController < PermissionsController
  def set_permissions_class; set_the_permissions_class(Role, :role, 'role_', 'Role', 'Role', :domain_type); end
  def set_permissions_object; @role = @permissions_object; end
end
