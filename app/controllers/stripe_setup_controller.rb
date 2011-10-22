class StripeSetupController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = current_user
    stripe_hash = params[:stripe]
    @user.set_live_stripe_keys stripe_hash[:live]
    @user.set_test_stripe_keys stripe_hash[:test]
    if @user.save
      flash.now[:success] = "Stripe keys saved"
    else
      flash.now[:error] = "There was an error saving your keys."
    end
    render :new
  end

  def confirm_live
    @user = current_user
    if @user.update_attribute :live_mode, true
      flash[:warning] = "You're live.  If your Stripe keys are correct, any payments made on your links will show up on your Stripe account."
    else
      flash[:error] = "Sorry. Can't go live. Email us at support@hipay.me"
    end
    redirect_to root_url
  end

  def confirm_demo
    @user = current_user
    @user.update_attribute :live_mode, false
    flash[:info] = "You're back to Demo mode. Any question or confirm, email us at support@hipay.me"
    redirect_to root_url
  end
end
