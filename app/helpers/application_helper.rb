module ApplicationHelper
  def space_with_metrics space
    space > 0 ? raw("#{space} м&sup2;") : t(:no_space)
  end
end
