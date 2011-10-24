module ApplicationHelper
  def span_for_currency number
    content_tag :span, :class => "money" do
      number_to_currency number
    end
  end

  def twitterized_type(type)
    case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      else
        type.to_s
    end
  end
end
