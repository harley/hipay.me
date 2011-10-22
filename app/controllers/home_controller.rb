class HomeController < ApplicationController
  def index
  end

  def dashboard
    @invoices = current_user.invoices 
    @payments = current_user.payments
  end
end
