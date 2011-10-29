class Item < ActiveRecord::Base
  validates_numericality_of :amount
  validates_presence_of :note
end
