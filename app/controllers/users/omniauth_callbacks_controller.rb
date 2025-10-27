class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env["omniauth.auth"]
    email = auth&.info&.email.presence || auth&.extra&.id_info&.[]("email").presence
    return redirect_to(new_user_session_path, alert: "Googleからメールアドレスを取得できませんでした。別のアカウントでお試しください。") unless email

    email = email.strip.downcase
    provider = auth.provider
    uid = auth.uid

    if (user = User.find_by(provider: provider, uid: uid))
      return success_sign_in(user)
    end

    if (existing = User.find_by(email: email))
      email_verified = auth&.info&.verified || auth&.info&.email_verified || auth&.extra&.id_info&.[]("email_verified")
      if email_verified
        existing.update!(provider: provider, uid: uid)
        return success_sign_in(existing)
      else
        return redirect_to new_user_session_path, alert: "このメールは既に登録されています。パスワードでログイン後、設定画面からGoogle連携してください。"
      end
    end

    user = User.new(
      provider: provider,
      uid: uid,
      email: email,
      password: Devise.friendly_token[0, 20]
    )
    user.save!(validate: false)
    success_sign_in(user)
  end

  def failure
    redirect_to unauthenticated_root_path, alert: "認証がキャンセルされました"
  end

  private

  def success_sign_in(user)
    sign_in_and_redirect user, event: :authentication
    set_flash_message :notice, :success, kind: "Google" if is_navigational_format?
  end
end
