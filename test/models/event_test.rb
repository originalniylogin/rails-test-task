require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event_handler = EventHandler.new(name: 'Exmaple')
    @event = Event.new(name: 'Exmaple',
                       location: 'Example',
                       event_handler: @event_handler,
                       starts_at: DateTime.now)
  end

  test 'should be valid' do
    assert @event.valid?
  end

  test 'name should be present' do
    @event.name = '    '
    assert !@event.valid?
  end

  test 'location should be present' do
    @event.location = '    '
    assert !@event.valid?
  end

  test 'starts at should be present' do
    @event.starts_at = nil
    assert !@event.valid?
  end

  test 'name should be unique' do
    dup = @event.dup
    dup.event_handler = @event_handler
    @event.save
    assert !dup.valid?
  end
end
