module Paddle
  class NotificationSetting < Object

    class << self

      def list(**params)
        response = Client.get_request("notification-settings", params: params)
        Collection.from_response(response, type: NotificationSetting)
      end

      def create(description:, destination:, type:, events:, **params)
        {description: description, destination: destination, type: type, subscribed_events: events}
        response = Client.post_request("notification-settings", body: attrs.merge(params))
        NotificationSetting.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("notification-settings/#{id}")
        NotificationSetting.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("notification-settings/#{id}", body: params)
        NotificationSetting.new(response.body["data"])
      end

      def delete(id:)
        Client.delete_request("notification-settings/#{id}")
      end

    end

  end
end
