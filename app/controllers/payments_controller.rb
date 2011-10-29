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
    respond_to do |format|
      format.html do
        render :layout => "app2"
      end
      format.pdf { doc_raptor_send }
    end
  end

  def doc_raptor_send(options = { })
    default_options = { 
      :name             => "payment",
      :document_type    => request.format.to_sym,
      :test             => !Rails.env.production?,
    }
    options = default_options.merge(options)
    options[:document_content] ||= render_to_string
    ext = options[:document_type].to_sym
    
    response = DocRaptor.create(options)
    if response.code == 200
      send_data response, :filename => "#{options[:name]}.#{ext}", :type => ext
    else
      render :inline => response.body, :status => response.code
    end
  end
end
