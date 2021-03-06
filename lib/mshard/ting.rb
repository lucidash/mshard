require 'thor'
require 'mshard'

module MShard
  class Ting < Thor::Group
    namespace :''
    argument :title, default: 'Ting!', required: false
    argument :body, required: false
    def ting
      MShard.new.set_safe(
        pushbullet: true,
        type: 'note',
        title: title,
        body: body
      )
    end
  end
end
