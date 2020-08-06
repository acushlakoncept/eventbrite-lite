class EventsController < ApplicationController
  before_action :require_user, except: [:index]

  def index
    @past = Event.past
    @upcoming = Event.upcoming
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = 'Event was created successfully'
      redirect_to events_path
    else
      flash[:alert] = 'Woops something went wrong'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  # def self.past
  #     Event.where(["date < ?", Date.today])
  # end

  # def self.upcoming
  #     Event.where(["date > ?", Date.today])
  # end

  private

  def event_params
    params.require(:event).permit(:description)
  end
end
