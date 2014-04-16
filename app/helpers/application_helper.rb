module ApplicationHelper
  def space_with_metrics space
    string = I18n.t('meters', count: space)
    space > 0 ? raw(string + "&sup2;") : I18n.t('no_space')
  end

  def space_with_metrics_hectars space
    string = I18n.t('hectars', count: space)
    space > 0 ? raw(string) : I18n.t('no_space')
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

  def duration_with_metrics duration
    duration > 0 ? I18n.t('datetime.distance_in_words.x_months', count: duration) : t('no_duration_set')
  end
end
