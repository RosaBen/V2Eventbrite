class AttendancesController < ApplicationController
  before_action :set_event
  before_action :set_attendance
  def index
    @attendances = Attendance.all
  end

  def show
    @attendance = Attendance.find(params[:id])
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = @event.attendances.build(user: current_user)
    if @attendance.save
      flash[:notice] = "Tu es inscrit à l'événement avec succès"
      redirect_to @event
    else
        flash.now[:alert] = "Erreur lors de l'inscription."
        render "attendances/shared/form", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @attendance.update(attendance_params)
      flash[:notice] = "Votre participation a été modifiée avec succès"
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy
    flash[:notice] = "Votre participation a été supprimée avec succès"
    redirect_to attendances_path
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_attendance
    @attendance = @event.attendances.find_by(user_id: current_user.id)
    redirect_to @event, alert: "Tu n'es pas inscrit à cet événement." unless @attendance
  end
  def attendance_params
    params.require(:attendance).permit(:user_id, :event_id, :stripe_customer_id)
  end
end
