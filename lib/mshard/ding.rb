require 'thor'
require 'mshard'

module MShard
  class Ding < Thor::Group
    namespace :''
    argument :text, default: 'Ding!', required: false
    def ding
      MShard.new.set_safe(
        slack: true,
        webhook_url: ENV['SLACK_WEBHOOK_URI'],
        channel: ENV['SLACK_CHANNEL'],
        text: text
      )
    end
  end
end
