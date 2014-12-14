module AcceptanceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.try(:email) || 'user@user.com'
    fill_in 'Password', with: user.try(:password) || 'some_password'
    click_on 'Log in'
  end
end