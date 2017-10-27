module FbServices
  class GroupPost
    ACCESS_TOKEN = Rails.application.secrets[:fb][:access_token]
    FB_GROUP_ID = Rails.application.secrets[:fb][:group_id]

    def self.send(message)
      graph = Koala::Facebook::API.new(ACCESS_TOKEN)
      graph.put_connections(FB_GROUP_ID, 'feed', message: message)
    end
  end
end
