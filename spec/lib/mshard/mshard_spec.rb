require 'mshard'

describe MShard::MShard do
  it '#try works' do
    expect(subject.try { :result }).to be(:result)
    expect(subject.try(delay: 0.01) { fail }).to be(nil)
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

  describe '#set' do
    before do
      expect(described_class).to receive(:post)
        .with('/v2/shards', body: :params).and_return('id' => :id)
    end

    it '#set works' do
      expect(subject.set(:params)).to eq(:id)
    end

    it '#set_safe works' do
      expect(subject.set_safe(:params)).to eq(:id)
    end
  end

  it '#set_error works' do
    expect(described_class).to receive(:post).and_return('id' => :id)
    e = double(inspect: :inspect, backtrace: [:a, :b])
    expect(subject.set_error(e)).to eq(:id)
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
