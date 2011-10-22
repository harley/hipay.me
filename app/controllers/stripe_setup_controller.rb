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
end
