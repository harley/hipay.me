require 'spec_helper'

describe "invoices/edit.html.erb" do
  before(:each) do
    @invoice = assign(:invoice, stub_model(Invoice,
      :user => nil,
      :name => "MyString",
      :amount => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit invoice form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invoices_path(@invoice), :method => "post" do
      assert_select "input#invoice_user", :name => "invoice[user]"
      assert_select "input#invoice_name", :name => "invoice[name]"
      assert_select "input#invoice_amount", :name => "invoice[amount]"
      assert_select "textarea#invoice_description", :name => "invoice[description]"
    end
  end
end
