module HomeHelper
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def invoice_token_link(token)
    link_to token, pay_invoice_by_token_url(token), :title => pay_invoice_by_token_url(token), :class => "tipsy_tooltip"
  end
end
