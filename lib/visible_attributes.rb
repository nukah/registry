module VisibleAttributes
  def self.included(base)
     base.extend(ClassMethods)
  end
  def visible_attributes
    @v_fields
  end

  module ClassMethods
    def visible *fields
      @v_fields = fields
    end
  end
end