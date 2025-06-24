class EventsController < ApplicationController
  before_action :set_event, only: [ :show, :edit, :update, :destroy, :guests ]

  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :authorize_owner!, only: [ :edit, :update, :destroy, :guests ]

  def index
    @events = Event.includes(:user, :attendances).order(start_date: :desc)
  end

  def show
    if params[:success] == "true" && current_user
      Attendance.find_or_create_by(user: current_user, event: @event)
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)


    respond_to do |format|
      if @event.save
        format.html {
          flash[:notice] = "Événement créé !"
          redirect_to event_path(@event)
        }
        format.json { render :show, status: :created, location: @event }
      else
        format.html {
          flash.now[:alert] = "Échec de la création : #{@event.errors.full_messages.join(', ')}"

          render :new
        }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html {
          flash[:notice] = "Événement mis à jour !"
          redirect_to event_path(@event)
        }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html {
          flash.now[:alert] = "Échec de la mise à jour."
          render :edit
        }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "Événement supprimé !"
        redirect_to events_path
      }
      format.json { head :no_content }
    end
  end

  def guests
    @attendances = @event.attendances.includes(:user)
  end

  private

  def authorize_owner!
    unless @event.user == current_user
      redirect_to events_path, alert: "Tu n'es pas autorisé à accéder à cette page."
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end
end
