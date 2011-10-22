module ApplicationHelper
  def span_for_currency number
    content_tag :span, :class => "money" do
      number_to_currency number
    end
  end
end
