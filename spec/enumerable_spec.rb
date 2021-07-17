require 'enumerable'
# rubocop:disable Lint/UselessAssignment
describe Enumerable do
  array = [1, 2, 3, 4, 5, 6, 7, 8]
  string_array = %w[uzair emanuel dan vic Oni]
  hash = { one: 1, two: 2, three: 3 }

  describe '#my_each' do
    context 'If no block given' do
      it 'returns enum' do
        expect(array.my_each).to be_an Enumerator
      end
    end

    context 'If a block is given and is an array' do
      it 'yields the result' do
        self_array = array.my_each do |num|
          num
        end
        expect(self_array).to eq([1, 2, 3, 4, 5, 6, 7, 8])
      end
    end

    context 'If a block is given and is a hash' do
      it 'yields the result' do
        self_hash = []
        hash.my_each do |key, value|
          self_hash << "Key #{key} and Value #{value}"
        end
        expect(self_hash).to eq(['Key one and Value 1', 'Key two and Value 2', 'Key three and Value 3'])
      end
    end

    context 'If a block is given and is a range' do
      it 'yields results in the range' do
        range = array[1..3]
        self_array = range.my_each do |num|
          num
        end
        expect(self_array).to eq([2, 3, 4])
      end
    end
  end
end
# rubocop:enable Lint/UselessAssignment
