class User < ActiveRecord::Base
  
  # is_paranoid
  has_and_belongs_to_many :roles, :order => "name ASC"
  
  acts_as_authentic do |c|
    c.login_field :login
    c.validates_presence_of :login
    c.validate_login_field true
    c.merge_validates_length_of_login_field_options :within => 6..31
    c.validates_format_of_email_field_options :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "^Email must be a valid email address."
    c.ignore_blank_passwords true
  end
  
  include Permissify::Roles
  PERMISSIFIED_ASSOCIATION = :roles
  # for brand,bus/merch : want this to be :permissible_products : added shell of product/interface for brand, merchant
  # dealer, corp  : PERMISSIFIED_ASSOCIATION = :products  
end
