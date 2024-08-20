class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :check_admin_access, if: :is_admin?
  
  skip_before_action :verify_authenticity_token

  def root
    if user_signed_in?
      redirect_to companies_path
    else
      redirect_to new_user_session_path # Or any public page like login
    end
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def check_admin_access
    unless current_user&.admin?
      sign_out current_user
      redirect_to root_path, alert: 'Access restricted to admins only.'
    end
  end

  def is_admin?
    current_user.present? && current_user.role != 1
  end
end
