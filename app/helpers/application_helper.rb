module ApplicationHelper
  def toast_color(key)
    color = "gray"
    case key
    when "error"
      color = "red"
    when "info"
      color = "blue"
    when "success"
      color = "green"
    when "warning"
      color = "orange"
    end
    color
  end
end
