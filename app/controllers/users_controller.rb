class UsersController < ApplicationController
  def index
    @users =User.all
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
    @event = Event.new
  end

  def new
    @user = User.new
  end

  def Create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
