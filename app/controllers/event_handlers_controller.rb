class EventHandlersController < ApplicationController

  def index
    load_event_handlers
  end

  def show
    load_event_handler
  end

  private

  def load_event_handlers
    @event_handlers = EventHandler.all
  end

  def load_event_handler
    @event_handler = EventHandler.find(params[:id])
  end

end
