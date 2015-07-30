require 'mshard/mshard'

describe MShard::MShard do
  xit 'works' do
    id = subject.set(contents: 'a')
    expect(subject.get(id)).to eq('a')
  end

  xit 'works' do
    subject.set(
      pushbullet: true,
      channel_tag: ENV['PUSHBULLET_CHANNEL'],
      type: 'link',
      title: 'title',
      body: 'body',
      contents: 'a'
    )
  end
end
