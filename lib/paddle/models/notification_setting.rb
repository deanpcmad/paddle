module Paddle
  class NotificationSetting < Object

    class << self

      def list(params = nil)
        response = Client.get_request("notification-settings", params: params)
        Collection.from_response(response, type: NotificationSetting)
      end

      def create(attrs)
        response = Client.post_request("notification-settings", body: attrs)
        NotificationSetting.new(response.body["data"])
      end

      def retrieve(id)
        response = Client.get_request("notification-settings/#{id}")
        NotificationSetting.new(response.body["data"])
      end

      def update(id, attrs)
        response = Client.patch_request("notification-settings/#{id}", body: attrs)
        NotificationSetting.new(response.body["data"])
      end

      def delete(id)
        Client.delete_request("notification-settings/#{id}")
      end

    end

  end
end
