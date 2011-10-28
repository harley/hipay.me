class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :log_additional_data

  protected
  def log_additional_data
    request.env["exception_notifier.exception_data"] = {
      :current_user => current_user
    }
  end
end
