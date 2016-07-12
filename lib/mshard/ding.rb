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
        text: text
      )
    end
  end
end
