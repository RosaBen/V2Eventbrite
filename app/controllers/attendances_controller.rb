class AttendancesController < ApplicationController
  def Index
    @attendances = Attendance.all
  end

  def show
    @attendance = Attendance.find(params[:id])
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      flash[:notice] = "Votre participation a été enregstrée avec succès"
      redirect_to @attendance
    else
      render :new
    end
  end

  def edit
    @attendance = Attendance.find(params[:id])
  end

  def update
    @attendance = Attendance.find(params[:id])
    if @attendance.update(attendance_params)
      flash[:notice] = "Votre participation a été mise à jour avec succès"
      redirect_to @attendance
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
  def attendance_params
    params.require(:attendance).permit(:user_id, :event_id, :stripe_customer_id)
  end
end
