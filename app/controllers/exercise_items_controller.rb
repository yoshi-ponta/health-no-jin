class ExerciseItemsController < ApplicationController
  def index
    @items_by_cat = ExerciseItem.ordered.group_by(&:category)
  end
end
