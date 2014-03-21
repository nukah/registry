class Composer
  class Aggregators

  end
  def initialize(attributes = [], filters = [])
    @search_attributes = attributes
    @search_filters = filters
    models = [Entity, Territory, Building, Level, Room, Contract, Leaser]
    @attributes = models.inject([]) { |result, model|
      result << model.attribute_names.map { |attribute| "#{model.send(:name).downcase}_#{attribute}" }
      result
    }.flatten
  end

  def query
    scope.select(select_fields)
  end

  def headers
    defined_attributes.map { |a| t(a) }
  end

  private
  def defined_attributes
    if @search_attributes.any?
      @attributes & @search_attributes
    else
      @attributes
    end
  end

  def scope
    Room.joins{level.building.territory.entity}.joins{contract.leaser}
  end

  def select_fields
    defined_attributes.map do |e|
      field = e.split("_", 2).each_with_index.map { |element, index| index == 0 ? element.pluralize : element }.join('.')
      "#{field} as #{e}"
    end
  end
end