module ApplicationHelper
  def space_with_metrics space
    space > 0 ? raw("#{space} м&sup2;") : t(:no_space)
  end

  def download_links fields, model
    if fields.is_a?(Array)
      raw fields.map { |file|
        link_to(t(file), send("download_#{file.to_s}_admin_#{model.class.name.downcase}_url", model)) if model.send(file).exists?
      }.join(' ')
    else
      link_to(t(fields), send("download_#{fields.to_s}_admin_#{model.class.name.downcase}_url", model)) if model.send(fields).exists?
    end
  end
end
