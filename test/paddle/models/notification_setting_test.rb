require "test_helper"

class NotificationSettingTest < Minitest::Test

  def test_notification_setting_list
    notification_settings = Paddle::NotificationSetting.list

    assert_equal Paddle::Collection, notification_settings.class
    assert_equal Paddle::NotificationSetting, notification_settings.data.first.class
    assert_equal "ntfset_01h7e0amn9q4wzn3k3syjszhtc", notification_settings.data.first.id
  end

  def test_notification_setting_retrieve
    notification_setting = Paddle::NotificationSetting.retrieve("ntfset_01h7e0amn9q4wzn3k3syjszhtc")

    assert_equal Paddle::NotificationSetting, notification_setting.class
    assert_equal "ntfset_01h7e0amn9q4wzn3k3syjszhtc", notification_setting.id
    assert_equal "Email", notification_setting.description
  end

  def test_notification_setting_create
    notification_setting = Paddle::NotificationSetting.create(
      {
        description: "Test Webhook",
        destination: "http://localhost:3000/webhook",
        type: "url",
        subscribed_events: ["transaction.billed"]
      }
    )

    assert_equal Paddle::NotificationSetting, notification_setting.class
    assert_equal "Test Webhook", notification_setting.description
  end

  def test_notification_setting_update
    notification_setting = Paddle::NotificationSetting.update("ntfset_01h7e0ebp7dz0ygz22bdkb5ckb", {
      subscribed_events: ["transaction.billed", "subscription.activated"]
    })

    assert_equal Paddle::NotificationSetting, notification_setting.class
    assert_equal "subscription.activated", notification_setting.subscribed_events.last.name
  end

  def test_notification_setting_delete
    notification_setting = Paddle::NotificationSetting.delete("ntfset_01h7e0ebp7dz0ygz22bdkb5ckb")

    assert_equal true, notification_setting
  end

end
