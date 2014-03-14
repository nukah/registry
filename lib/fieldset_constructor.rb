module Rentreport
  class Fieldset
    def initialize
      @models = [Building, Contract, Entity, Leaser, Level, Purpose, Room, Territory]
    end

    def construct
      block = @models.inject({}) { |hash, model|
        properties = model.columns.select { |field|
          model.fieldset.include?(field.name) if model.respond_to?('fieldset') && model.fieldset.any? }.inject({}) { |props, field|
            props.merge({field.name => {title: I18n.t("activerecord.attributes.#{model.name.downcase}.#{field.name}") , type: field.type}})
        }
        hash.merge({model.to_s.downcase => { type: 'object', title: I18n.t("form_model_titles.#{model.name.downcase}"), properties: properties } })
      }
      block
    end
  end
end