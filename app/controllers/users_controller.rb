class UsersController < ApplicationController
  before_action :authenticate_user!, :ensure_admin!

  def index
    @users = User.all
  end
end
