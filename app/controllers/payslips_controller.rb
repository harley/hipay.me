class PayslipsController < InvoicesController
  # just here for mockup purpose for now...
  def new
    @invoice = current_user.invoices.build
  end

  def edit
    render 'new'
  end
end
