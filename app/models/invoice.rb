class Invoice < ActiveRecord::Base
  belongs_to :user

  before_create :generate_token

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

end
