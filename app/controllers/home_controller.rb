class HomeController < ApplicationController
  def index
    if current_user
      if current_user.no_invoices_yet?
        flash[:success] = "Welcome! Try creating a payment link to see how easy it is to collect Credit Card payments!"
        redirect_to new_invoice_path
      else
        redirect_to dashboard_path, :flash => flash
      end
    end
  end

  def dashboard
    @invoices = current_user.invoices 
    @payments = current_user.payments
  end
end
