class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[terms privacy] rescue nil

  def privacy; end
  def terms; end
end
