class CreateEntities < ActiveRecord::Migration
  
  def up
    create_table :dealers, :force => true do |t|
      t.string   :name
      t.timestamps
    end

    create_table :corporations, :force => true do |t|
      t.string   :name
      t.integer  :dealer_id
      t.timestamps
    end
    
    create_table :brands, :force => true do |t|
      t.string   :name
      t.integer  :dealer_id
      t.integer  :corporation_id
      t.timestamps
    end
    
    create_table :merchants, :force => true do |t|
      t.string   :name
      t.integer  :dealer_id
      t.integer  :corporation_id
      t.integer  :brand_id
      t.timestamps
    end
    
  end

  def down
    drop_table :merchants
    drop_table :brands
    drop_table :corporations
    drop_table :dealers
  end
  
end
