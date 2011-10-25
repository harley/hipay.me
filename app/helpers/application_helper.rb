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

  def custom_error_messages(record)
    if record.errors.any?
      title = content_tag(:h2, pluralize(record.errors.count, "error"))
      errors = record.errors.full_messages.map{|msg| content_tag(:li, msg)}.join.html_safe
      wrapper = content_tag :ul, title + errors
      content_tag(:div, wrapper, :id => "error_explanation")
    else
      ""
    end
  end
end
