class PaymentMailer < ActionMailer::Base
  default from: "support@hipay.me"

  def receipt(payment)
    @payment = payment
    mail :to => payment.email, :subject => "Invoice for your payment."
  end
end
