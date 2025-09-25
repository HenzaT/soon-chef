module RecipesHelper
  include Devise::Controllers::Helpers
  def logout_of_session
    link_to 'Logout', destroy_user_session_path, data: { turbo_method: :delete } if user_signed_in?
  end

  def welcome_user
    "Hi #{current_user.first_name}" if user_signed_in?
  end
end
