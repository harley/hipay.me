require 'spec_helper'

describe Invoice do
  pending "add some examples to (or delete) #{__FILE__}"
  it "should create a token" do
    @invoice = Invoice.create! :description => "description", :amount => "12", :user => User.create!
    @invoice.token.should be_present
  end
end
