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

    @event_handlers = @event_handlers.paginate(page: params[:page], per_page: 10)
  end

  def load_event_handler
    @event_handler = EventHandler.find(params[:id])
    @events = @event_handler.events
  end

end
