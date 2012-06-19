# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Role.seed

if Admin.count == 0
  a = Admin.new
  a.name = 'admin'
  a.save
  a.roles << Role.first
end

Product.seed

if User.count == 0
  a = Admin.first
  su = a.users.new
  su.login = 'superuser'
  su.password = 'password1'
  su.password_confirmation = 'password1'
  su.email = 'superuser@permissify.gov'
  su.roles = [Role.first]
  # su.entity = a # needed? shouldn;t be
  su.save
end
