require "test_helper"

class EventTypeTest < Minitest::Test
  def test_event_type_list
    event_types = Paddle::EventType.list

    assert_equal Paddle::Collection, event_types.class
    assert_equal Paddle::EventType, event_types.data.first.class
    assert_equal "transaction.billed", event_types.data.first.name
  end
end
