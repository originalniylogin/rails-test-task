module EventsHelper

  def event_description
    @event.description.gsub! '\n', '<br />'
  end

end
