class UsersController < ApplicationController
  before_action :set_user
  def index
    @users =User.all
  end
  def show
    @created_events = @user.created_events.order(start_date: :desc)
    @attendances = @user.attendances.where.not(stripe_customer_id: nil).includes(:event)
    @participated_events = @attendances.map(&:event).reject { |event| event.user == @user }
  end
  def new
    @user = User.new
  end

  def Create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "✅ Informations mises à jour avec succès."
    else
      flash.now[:alert] = "❌ Une erreur est survenue."
      render :show
    end
  end

  def destroy
  end

  private

  def set_user
    @user = current_user
  end
  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :email, :password, :password_confirmation)
  end
end
