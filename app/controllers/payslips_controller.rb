class PayslipsController < InvoicesController
  # just here for mockup purpose for now...
  def new
    @invoice = current_user.invoices.build
  end

  def edit
    @invoice = Invoice.find params[:id]
    params[:invoice] ||= {}
    if @invoice.express?
      params[:invoice][:mode] = "express"
    else
      params[:invoice][:mode] = "custom"
    end
  end
end
