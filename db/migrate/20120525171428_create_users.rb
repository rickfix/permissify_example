class CreateUsers < ActiveRecord::Migration
  def up
    
    create_table :users, :force => true do |t|
      t.string   :login, :limit => 20
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :persistence_token, :limit => 40
      t.string   :perishable_token, :default => "", :null => false
      t.string   :email, :limit => 255
      t.references :entity, :polymorphic => true    
      t.timestamps
    end

  end

  def down
    drop_table :users
  end
end
