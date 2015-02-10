require 'mshard/mshard'

describe MShard::MShard do
  it 'works' do
    id = subject.set(contents: 'a')
    expect(subject.get(id)).to eq('a')
  end
end
