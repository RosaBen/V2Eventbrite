class EventsController < ApplicationController
  def index
    @events =Event.includes(:user).order(start_date: :asc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = "Evenement Créé!"
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Failed to create event."
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:notice] = "Evenement Mis à Jour!"
      redirect_to event_path(@event)
    else
      flash.now[:alert] = "Evenement non ajouté."
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Evenement Supprimé!"
    redirect_to events_path
  end

  private
  # puts "PARAMS ----------"
  # puts params.inspect
  # puts "-----------------"
  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end
end
