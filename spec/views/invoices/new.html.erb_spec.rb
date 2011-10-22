require 'spec_helper'

describe "invoices/new.html.erb" do
  before(:each) do
    assign(:invoice, stub_model(Invoice,
      :user => nil,
      :name => "MyString",
      :amount => 1,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new invoice form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invoices_path, :method => "post" do
      assert_select "input#invoice_user", :name => "invoice[user]"
      assert_select "input#invoice_name", :name => "invoice[name]"
      assert_select "input#invoice_amount", :name => "invoice[amount]"
      assert_select "textarea#invoice_description", :name => "invoice[description]"
    end
  end
end
