require 'httparty'

module MShard
  class MShard
    include HTTParty
    base_uri "#{ENV['MSHARD_URI']}/shards"

    def get(id)
      self.class.get("/#{id}")['contents']
    end

    def set(params)
      self.class.post('', body: params)['id']
    end
  end
end
