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

  describe '#get' do
    before do
      expect(described_class).to receive(:get)
        .with('/v2/shards/id').and_return(double(body: :done))
    end

    it '#get works' do
      expect(subject.get(:id)).to eq(:done)
    end

    it '#get_safe works' do
      expect(subject.get_safe(:id)).to eq(:done)
    end
  end

  it '#set works' do
    expect(described_class).to receive(:post)
      .with('/v2/shards', body: :params).and_return('id' => :id)
    expect(subject.set(:params)).to eq(:id)
  end

  it '#error_to_html works' do
    e = begin
          fail
        rescue => e
          e
        end
    html = (subject.error_to_html(e))
    expect(html).to include('<title>Error</title>')
    expect(html).to include('<pre>RuntimeError</pre>')
  end
end
