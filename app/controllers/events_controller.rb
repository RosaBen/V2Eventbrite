class EventsController < ApplicationController
  def index
    @events =Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def Create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
