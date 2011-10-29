class Payment < ActiveRecord::Base
  belongs_to :invoice

  attr_accessor :stripe_card_token
  attr_accessor :description_for_stripe

  serialize :stripe_response, Stripe::Charge

  before_create :parse_stripe_response
  delegate :token, :to => :invoice

  def charge_and_save
    if valid?
      Stripe.api_key = invoice.user.stripe_private_key

      self.stripe_response = Stripe::Charge.create(:card => stripe_card_token, 
                                                   :amount => invoice.amount_in_cents, 
                                                   :currency => "usd", 
                                                   :description => description_for_stripe)
      self.save!
      true
    else
      false
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end

  def send_receipt
    PaymentMailer.receipt(self).deliver
  end

  def invoice_token
    invoice.try :token
  end

  def invoice_token=(token)
    self.invoice ||= Invoice.find_by_token(token) 
  end

  def parse_stripe_response
    if stripe_response
      self.live_mode = stripe_response.livemode
      self.last4 = stripe_response.card.last4
      self.amount = stripe_response.amount * 0.01
    end
  end
end

# 
#     customer = Stripe::Customer.create(:card => stripe_card_token, :description => "#{researcher.full_name} - #{researcher.email}")
#     
#     # DEBUG
#     puts "Stripe::Customer token:"
#     y customer
# 
#     self.researcher.update_attribute :stripe_customer_token, customer.id
#     credit_card = CreditCard.create! :researcher => researcher, :card => customer.active_card, :name => name_on_card
# 
#     charge = Stripe::Charge.create(:customer => customer.id,
#                           :currency => "usd", 
#                           :amount => (total_cost*100).to_i,
#                           :description => "Charge for pool request ##{id}, study ##{study.title}")
# 
#     # DEBUG
#     puts "Stripe::Charge object"
#     y charge
# 
