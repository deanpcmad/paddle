require "test_helper"

class EventTest < Minitest::Test

  def test_event_list
    events = Paddle::Event.list

    assert_equal Paddle::Collection, events.class
    assert_equal Paddle::Event, events.data.first.class
    assert_equal "business.updated", events.data.first.event_type
  end

end
