class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def noop; end

  alias :index :noop
  alias :new :noop
  alias :edit :noop
  alias :show :noop
  alias :destroy :noop
  alias :create :noop
  alias :update :noop

end
