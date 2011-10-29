class PaymentsController < ApplicationController
  def new
    if @invoice = Invoice.find_by_token(params[:invoice_token])
      @payment = @invoice.payments.build
      @no_banner = true
    end
  end

  def create
    @payment = Payment.new params[:payment]
    if @payment.charge_and_save
      AdminMailer.new_record_alert(@payment).deliver if @payment.invoice.user.live_mode?
      redirect_to @payment, :notice => "Thank you!"
    else
      flash[:error] = "There was an error processing your card."
      render :new
    end
  end

  def show
    @payment = Payment.find params[:id]
  end

  def update
    @payment = Payment.find params[:id]
    if params[:payment][:email]
      @payment.update_attribute :email, params[:payment][:email]
      @payment.send_receipt
      redirect_to thankyou_payment_path(@payment)
    end
  end

  def thankyou
    @payment = Payment.find params[:id]
  end
end
