require "rails_helper"

RSpec.describe "Password reset", type: :system do
  let!(:user) { create(:user, email: "user@example.com") }

  it "メールのリンクから再設定ができる" do
    visit new_user_password_path
    fill_in "メールアドレス", with: user.email
    click_button "パスワード再設定用リンクを送信"

    mail  = ActionMailer::Base.deliveries.last
    body  = (mail.html_part&.body&.to_s.presence || mail.body.encoded)
    token = body[/reset_password_token=([^"&]+)/, 1]

    visit edit_user_password_path(reset_password_token: token)
    fill_in "user_password", with: "new-pass-123"
    fill_in "user_password_confirmation", with: "new-pass-123"
    click_button "パスワードを変更する"

    expect(page).to have_text("パスワードを変更しました")
  end
end
