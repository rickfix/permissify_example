class Merchant < ActiveRecord::Base
  
  has_many :users, :as => :entity, :dependent => :destroy

  def parent; self.brand; end

end
