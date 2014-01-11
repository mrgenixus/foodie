class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :user_time_zone
  before_filter :get_time_zone

  def noop; end

  alias :index :noop
  alias :new :noop
  alias :edit :noop
  alias :show :noop
  alias :destroy :noop
  alias :create :noop
  alias :update :noop

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password, :password_confirmation, :name, :email) }
  end

  private

  def user_time_zone
    @time_zone ||= Time.zone = session[:time_zone].present? && session[:time_zone]
  end

  def get_time_zone
    @time_zone = params[:time_zone] if params[:time_zone].present?
  end

end
