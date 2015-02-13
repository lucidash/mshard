require 'httparty'

module MShard
  class MShard
    include HTTParty
    base_uri ENV['MSHARD_URI']

    def get(id)
      self.class.get("/v2/shards/#{id}").body
    end

    def set(params)
      self.class.post('/v2/shards', body: params)['id']
    end
  end
end
