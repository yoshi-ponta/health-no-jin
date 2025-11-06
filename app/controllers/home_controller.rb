class HomeController < ApplicationController
  before_action :authenticate_user!


  def index
    @progress = @active_group
  end
end
