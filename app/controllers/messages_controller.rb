class MessagesController < ApplicationController
  private
  def message_params
    params.require(:message).permit(:image)
  end
end
