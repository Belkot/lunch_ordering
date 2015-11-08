class UsersController < ApplicationController
  before_action :ensure_admin!

  def index
    @users = User.all
  end
end
