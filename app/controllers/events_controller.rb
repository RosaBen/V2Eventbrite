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

  def Create
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
  def gossip_params
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end
end
