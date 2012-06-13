class BrandsController < EntityController
  def set_nav
    @active_tab = 'brand'
    @active_section = 'Brand Admin'
    @list_association = :merchants
  end
end
