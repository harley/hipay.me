class PaymentsController < ApplicationController
  def new
    if @invoice = Invoice.find_by_token(params[:invoice_token])
      @payment = @invoice.payments.build :payer_name => @invoice.name
      @no_banner = true
    else
      flash[:error] = "Invalid link."
      redirect_to root_url
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
    @payment = Payment.find_by_access_token! params[:id]
  end

  def update
    @payment = Payment.find_by_access_token! params[:id]
    if params[:payment][:email]
      @payment.update_attribute :email, params[:payment][:email]
      @payment.send_receipt
      redirect_to thankyou_payment_path(@payment)
    end
  end

  def thankyou
    @payment = Payment.find_by_access_token! params[:id]
  end

  def invoice
    if @payment = Payment.find_by_access_token(params[:id])
      respond_to do |format|
        format.html { render :layout => false }
        format.pdf do
          # showing image is throwing timeout error because of docraptor <-> heroku
          # hence disabling as default, but overridable with params[:i]
          @hide_image = true unless params[:i]
          doc_raptor_send
        end
      end
    else
      flash[:error] = "Invalid link"
      redirect_to root_path
    end
  end

  def doc_raptor_send(options = { })
    default_options = {
      :name             => action_name,
      :document_type    => request.format.to_sym,
      :test             => !Rails.env.production?,
    }
    options = default_options.merge(options)
    options[:document_content] ||= render_to_string(:file => "/payments/invoice.html.erb", :layout => false)
    ext = options[:document_type].to_sym

    response = DocRaptor.create(options)
    #y options[:document_content]
    if response.code == 200
      send_data response, :filename => "#{options[:name]}.#{ext}", :type => ext
    else
      render :inline => response.body, :status => response.code
    end
  end
end
