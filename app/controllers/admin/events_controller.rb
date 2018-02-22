class Admin::EventsController < AdminController
  def index
    load_events
  end

  def show
    load_event
  end

  def new
    build_event
  end

  def create
    build_event
    save_event 'new'
  end

  def edit
    load_event
  end

  def update
    load_event
    build_event
    save_event 'edit'
  end

  def destroy
    load_event
    @event.destroy
    redirect_to admin_events_path
  end

  def email_subscribers
    load_event
    Subscriber.all.each do |sub|
      SubscriberMailer.notification_email(sub, @event).deliver_later
    end
    redirect_to admin_event_path(@event)
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
      @events =
        case params[:status]
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

  def build_event
    if @event
      @event.attributes = event_params
    else
      @event = Event.new event_params
    end
  end

  def save_event(option)
    if @event.save
      redirect_to admin_event_path @event
    else
      flash.now[:danger] = @event.errors
      render option
    end
  end

  def event_params
    event_params = params[:event]
    if event_params
      event_params.permit(:name,
                          :location,
                          :description,
                          :url,
                          :event_handler_id,
                          :starts_at,
                          :image)
    else
      {}
    end
  end
end
