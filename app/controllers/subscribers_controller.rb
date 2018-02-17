class SubscribersController < ApplicationController

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(params.require(:subscriber).permit(:email))

    if @subscriber.save
      redirect_to events_path
    else
      flash.now[:danger] = @subscriber.errors
      render 'new'
    end
  end

end
