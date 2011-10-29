class Invoice < ActiveRecord::Base
  image_accessor :logo

  #TODO add this column
  attr_accessor :payee
  attr_accessor :mode

  belongs_to :user
  has_many :payments
  has_many :items, :dependent => :destroy
  accepts_nested_attributes_for :items, :reject_if => lambda {|a| a[:note].blank? }, :allow_destroy => true

  before_create :generate_token
  validates_uniqueness_of :token, :allow_blank => true
  validates_presence_of :amount, :unless => :is_custom_mode
  validates_presence_of :description
  validates_presence_of :user_id
  validates_numericality_of :amount, :greater_than => 0, :unless => :is_custom_mode

  def amount_in_cents
    (amount * 100).to_i
  end

  def total_collected
    payments.sum(:amount)
  end

  def not_yet_used?
    payments.size.zero?  
  end

  def amount
    if items.size > 0
      items.sum(:amount)
    else
      read_attribute(:amount)
    end  
  end

  private
  def generate_token
    self.token = Invoice.alphanumeric_random 5
  end

  ALPHANUMERIC = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  VALID_ALPHANUMERIC = ALPHANUMERIC - ['o','O','0','i','l','L','I','8','B','D','Q','1']
  def self.alphanumeric_random(n)
    s = ""
    1.upto(n){|i| s << VALID_ALPHANUMERIC.sample}
    s
  end

  def is_custom_mode
    mode == "custom"
  end
end
