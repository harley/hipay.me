class PaymentsController < ApplicationController
  def new
    @invoice = Invoice.find_by_token params[:invoice_token]
    @payment = @invoice.payments.build
  end

end
