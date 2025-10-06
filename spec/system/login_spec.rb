require 'rails_helper'

RSpec.describe 'ログイン導線', type: :system do
  describe 'ログインしてホームに到達' do
    it '到達できる' do
      user = create(:user)

      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'ログイン'
    end
  end
end