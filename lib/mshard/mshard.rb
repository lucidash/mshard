require 'httparty'
require 'no_proxy_fix'
require 'haml'

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

    def try(times: 3, delay: 2)
      times.times do
        begin
          return yield
        rescue
          sleep delay
        end
      end
      nil
    end

    def get_safe(*args)
      try { get(*args) }
    end

    def set_safe(*args) # rubocop:disable Style/AccessorMethodName
      try { set(*args) }
    end

    ERROR_TEMPLATE = <<-HAML.freeze
!!! 5
%html
  %head
    %meta{ name: 'viewport', content: 'width=device-width,initial-scale=1.0' }
    %title Error
  %body
    %p
      %pre
        &= e.inspect
    %p
      %pre
        &= e.backtrace.join("\\n")
      HAML

    def error_to_html(e)
      Haml::Engine.new(ERROR_TEMPLATE).render(Object.new, e: e)
    end

    def set_error(e, **opt)
      set_safe(
        {
          pushbullet: true,
          type: 'link',
          title: 'Error!',
          body: "#{e.class}\nClick here",
          contents: error_to_html(e)
        }.merge(opt)
      )
    end
  end
end
