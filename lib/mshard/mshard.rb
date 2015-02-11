require 'httparty'

module MShard
  class MShard
    include HTTParty
    base_uri ENV['MSHARD_URI']

    def get(id)
      self.class.get("/shards/#{id}")['contents']
    end

    def set(params)
      self.class.post('/shards', body: params)['id']
    end
  end
end
