class EventsController < ApplicationController
  def index
    @events =Event.all
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
  end

  def update
  end

  def destroy
  end

  private
  # puts "PARAMS ----------"
  # puts params.inspect
  # puts "-----------------"
  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end
end
