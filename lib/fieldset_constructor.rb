module Rentreport
  class Fieldset
    def initialize
      @models = [Building, Contract, Entity, Leaser, Level, Purpose, Room, Territory]
    end

    def construct
      result = @models.inject({}) { |result, model|
        result.merge(
          model.to_s.downcase => Hash[model.columns.select { |field|
          model.fieldset.include?(field.name) if model.respond_to?('fieldset') && model.fieldset.any? }.map { |field| [field.name, field.type]}]
        )
      }
      result.delete_if { |k,v| v.empty? }
    end
  end
end