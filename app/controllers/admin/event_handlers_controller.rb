class Admin::EventHandlersController < ApplicationController
  def index
    load_event_handlers
  end

  def show
    load_event_handler
  end

  def new
    build_event_handler
  end

  def create
    build_event_handler
    save_event_handler 'new'
  end

  def edit
    load_event_handler
  end

  def update
    load_event_handler
    build_event_handler
    save_event_handler 'edit'
  end

  def destroy
    load_event_handler
    @event_handler.destroy
    redirect_to admin_event_handlers_path
  end

  private

  def load_event_handlers
    @event_handlers = EventHandler.where(nil)
    @event_handlers = @event_handlers.ordered_by_date

    @event_handlers = @event_handlers.paginate(page: params[:page], per_page: 10)
  end

  def load_event_handler
    @event_handler = EventHandler.find(params[:id])
  end

  def build_event_handler
    if @event_handler
      @event_handler.attributes = event_handler_params
    else
      @event_handler = EventHandler.new event_handler_params
    end
  end

  def save_event_handler(option)
    if @event_handler.save
      redirect_to admin_event_handler_path @event_handler
    else
      flash.now[:danger] = @event_handler.errors
      render option
    end
  end

  def event_handler_params
    event_handler_params = params[:event_handler]
    event_handler_params ? event_handler_params.permit(:name, :description) : {}
  end
end
