class User < ActiveRecord::Base
  
  acts_as_authentic do |c|
    c.login_field :login
    c.validates_presence_of :login
    c.validate_login_field true
    c.merge_validates_length_of_login_field_options :within => 6..31
    c.ignore_blank_passwords true
  end
  
  belongs_to :entity, :polymorphic => true
  
  include Permissify::Roles
  PERMISSIFIED_ASSOCIATION = :roles
  has_and_belongs_to_many :roles, :order => "name ASC"
  
end
