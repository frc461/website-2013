class EventsController < InheritedResources::Base
  load_and_authorize_resource
    def index
      if current_user
        @events = Event.all
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @events.map{|a| a.calendarify()} }
        end
      else
        @events = Event.where(:public => true)
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @events.map{|a| a.calendarify()} }
        end
      end
    end
  end
