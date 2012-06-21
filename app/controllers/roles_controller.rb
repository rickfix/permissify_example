class RolesController < PermissionsController
  def set_permissions_class
    set_the_permissions_class(Role, :role, 'role_', 'Role', 'Roles', :domain_type)
  end
  def set_permissions_object; @role = @permissions_object; end
  def set_permissions_object_specific_values(attrs)
    @permissions_object.domain_type = attrs[:domain_type]
    @permissions_object.manage_ids = attrs[:manage_ids]
    @permissions_object.manager_ids = attrs[:manager_ids]
  end
end
