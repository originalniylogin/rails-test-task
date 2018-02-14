class EventsController < ApplicationController

  def index
    load_events
  end

  def show
    load_event
  end

  private

  def load_events
    @events ||= Event.all
  end

  def load_event
    @event ||= Event.find(params[:id])
  end

end
