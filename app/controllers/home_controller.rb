class HomeController < ApplicationController
  def index
    if current_user
      redirect_to new_invoice_path
    end
  end

  def dashboard
    @invoices = current_user.invoices 
    @payments = current_user.payments
  end
end
