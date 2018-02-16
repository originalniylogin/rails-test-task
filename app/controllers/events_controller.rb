class EventsController < ApplicationController

  def index
    load_events
  end

  def show
    load_event
  end

  private

  def load_events
    @events = Event.where(nil)
    @events = @events.ordered_by_date

    # Filtering
    @events = @events.name_search(params[:name]) if params[:name].present?
    @events = @events.location_search(params[:location]) if params[:location].present?
    @events = @events.event_handler_search(params[:event_handler]) if params[:event_handler].present?
    if params[:status].present?
      @events = case params[:status]
                  when 'before'
                    @events.before_now(DateTime.now)
                  when 'after'
                    @events.after_now(DateTime.now)
                  else
                    @events
                end
    end

    # Pagination
    @events = @events.paginate(:page => params[:page], :per_page => 1)
  end

  def load_event
    @event ||= Event.find(params[:id])
  end

end
