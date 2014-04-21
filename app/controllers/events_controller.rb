require 'icalendar'

class EventsController < InheritedResources::Base
	load_and_authorize_resource

	def icalendarify (event_list)
		cal = Icalendar::Calendar.new

		event_list.each do |ev|
			cal.event do
				dtstart     ev.start_date_icalendar
				dtend       ev.end_date_icalendar
				summary     ev.title
				description ev.content
			end
		end

		cal.to_ical
	end

	def unrepeatify
		events_with_repeats = @events.dup

		@events.each do |ev|
			if ev.weeks_repeat && ev.weeks_repeat > 0
				start_date = ev.start_date + ev.weeks_repeat.weeks
				end_date = ev.end_date + ev.weeks_repeat.weeks

				while (!ev.end_repeat ||
				       start_date < ev.end_repeat) &&
						start_date < (DateTime.now + 365.days)
					new_event            = ev.dup
					new_event.start_date = start_date
					new_event.end_date   = end_date
					new_event.id         = ev.id
					events_with_repeats << new_event

					start_date += ev.weeks_repeat.weeks
					end_date   += ev.weeks_repeat.weeks
				end

				ev.weeks_repeat = nil
			end
		end

		events_with_repeats
	end

	def create
		@event = Event.new(params[:event])

		if @event.save
			redirect_to @event, notice: "Event created successfully!"
		else
			flash[:error] = view_context.join_errors(@event.errors)

			render :new
		end
	end

	def update
		@event = Event.find(params[:id])

		if @event.update_attributes(params[:event])
			redirect_to @event, notice: "Event updated successfully!"
		else
			flash[:error] = view_context.join_errors(@event.errors)

			render :edit
		end
	end

	def index
		if current_user
			@events = Event.all

			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: unrepeatify().map{|a| a.calendarify} }
				format.ics { render text: icalendarify(unrepeatify) }
			end
		else
			@events = Event.where(public: true)

			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: unrepeatify().map{|a| a.calendarify()} }
				format.ics { render text: icalendarify(unrepeatify) }
			end
		end
	end
end
