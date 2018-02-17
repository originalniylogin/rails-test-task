class EventsController < ApplicationController

  def index
    load_events
  end

  def show
    load_event
  end

  def download_ics
    load_event
    send_data generate_ics(@event),
              type: 'text/calendar',
              filename: "#{@event.name}.ics"
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
    @events = @events.paginate(page: params[:page], per_page: 10)
  end

  def load_event
    @event ||= Event.find(params[:id])
  end

  def generate_ics(event)
    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart = Icalendar::Values::DateTime.new(event.starts_at)
      e.dtend = Icalendar::Values::DateTime.new(event.starts_at)
      e.summary = event.name
      e.description = event.description
      e.url = event.url
      e.location = event.location
    end

    cal.to_ical
  end

end
