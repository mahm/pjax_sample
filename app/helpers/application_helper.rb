module ApplicationHelper
  def application_name
    'Pjax Sample'
  end

  def selected_class(path)
    current_page?(path) ? 'selected' : nil
  end
end
