module EventsHelper

  def event_description
    @event.description.gsub! '\r', '<br />'
  end

end
