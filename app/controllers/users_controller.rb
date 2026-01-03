class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  before_action :ensure_current_user, only: [:edit, :update, :settings, :update_settings]

  def index
    # List all users with search and filtering
    @users = User.order(created_at: :desc)

    # Search by name, username, or email
    if params[:query].present?
      @users = @users.where(
        "first_name ILIKE ? OR last_name ILIKE ? OR username ILIKE ? OR email ILIKE ?",
        "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"
      )
    end

    # Pagination ready (uncomment when using pagy or kaminari)
    # @pagy, @users = pagy(@users, items: 12)

    @users = @users.limit(50) # Temporary limit until pagination is added
  end

  def show
    # Public profile page
  end

  def edit
    # Edit profile page
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def settings
    # Account settings page (password, email, etc.)
  end

  def update_settings
    if @user.update_with_password(settings_params)
      bypass_sign_in(@user) # Sign in user again after password change
      redirect_to settings_path, notice: 'Settings updated successfully!'
    else
      render :settings, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :avatar)
  end

  def settings_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end
