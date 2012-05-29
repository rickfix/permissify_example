class UsersRolesProducts < ActiveRecord::Migration
  def up
    
    create_table :users, :force => true do |t|
      t.string   :login, :limit => 20
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :persistence_token, :limit => 40
      t.string   :perishable_token, :default => "", :null => false
      t.string   :email, :limit => 255
      t.timestamps
    end
    
    create_table  :roles, :force => true do |t|
      t.string    :name, :limit => 31
      t.string    :domain_type, :limit => 31
      t.text      :can_manage_roles
      t.text      :permissions
      t.timestamps
    end
    
    create_table :roles_users, :id => false, :force => true do |t|
      t.integer :role_id, :null => false
      t.integer :user_id, :null => false
    end
    
    create_table  :products, :force => true do |t|
      t.string    :name
      t.text      :permissions
      t.datetime  :deleted_at
    end
    
    # create_table :businesses_products, :id => false, :force => true do |t|
    #   t.integer :business_id, :null => false
    #   t.integer :product_id, :null => false
    # end

  end

  def down
    drop_table :users
    drop_table :roles
    drop_table :roles_users
    drop_table :products
    # drop_table :businesses_products
  end
end
