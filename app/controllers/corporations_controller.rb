class CorporationsController < EntityController

  def set_nav
    @active_tab = 'corporation'
    @active_section = 'Corporation Admin'
    @active_nav = 'Corporations'
    @entity_list = Corporation.all
    @new_entity = Corporation.new
    @create_path = new_corporation_path
    @add_label = 'new corporation'
    @index_columns = 1
  end

end
