module PayslipsHelper
  def add_item_link(&block)
    link_to "#", :id => "add_item", &block
  end
end
