require 'enumerable'

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

  describe '#my_each_with_index' do
    context 'If no block given' do
      it 'returns enum' do
        expect(array.my_each_with_index).to be_an Enumerator
      end
    end

    context 'If a block is given and is an array' do
      it 'yields hash with index of an element' do
        self_hash = {}
        string_array.my_each_with_index do |value, index|
          self_hash[index] = value
        end
        expect(self_hash).to eq({ 0 => 'uzair', 1 => 'emanuel', 2 => 'dan', 3 => 'vic', 4 => 'Oni' })
      end
    end

    context 'If a block is given and is a hash' do
      it 'yields hash with index of a value' do
        self_hash = {}
        hash.my_each_with_index do |key, value|
          self_hash[key] = value
        end
        expect(self_hash).to eq({ [:one, 1] => 0, [:two, 2] => 1, [:three, 3] => 2 })
      end
    end

    context 'if a block is given and is a range' do
      it 'yields hash with index of a value and range' do
        self_hash = {}
        range = array[3..6]
        range.my_each_with_index do |key, value|
          self_hash[key] = value
        end
        expect(self_hash).to eq({ 4 => 0, 5 => 1, 6 => 2, 7 => 3 })
      end
    end
  end

  describe '#my_select' do
    context 'If no block given' do
      it 'returns enum' do
        expect(array.my_select).to be_an Enumerator
      end
    end

    context 'If a block is given and is an array' do
      it 'yields the selected result' do
        self_array = []
        array.my_select do |i|
          self_array << i if i.odd?
        end
        expect(self_array).to eq([1, 3, 5, 7])
      end
    end

    context 'If a block is given and is a hash' do
      it 'yields the selected result' do
        self_hash = {}
        hash.my_select do |key, value|
          self_hash[key] = value if value.odd?
        end
        expect(self_hash).to eq({ one: 1, three: 3 })
      end
    end

    context 'If a block is given and is a range' do
      it 'yields the selected result in range' do
        self_array = []
        range = array[2..6]
        range.my_select do |i|
          self_array << i if i.even?
        end
        expect(self_array).to eq([4, 6])
      end
    end
  end

  describe '#my_all?' do
    context 'If no block given' do
      it 'returns true' do
        empty_array = []
        expect(empty_array.my_all?).to be_truthy
      end
    end

    context 'if block given is nil' do
      it 'returns false' do
        nil_array = [nil]
        expect(nil_array.my_all?).to be_falsey
      end
    end

    context 'If a block is given and checks the class' do
      it 'returns true' do
        self_array = array.all?(Numeric)
        expect(self_array).to be_truthy
      end
    end

    context 'If a block is given and does not checks the class' do
      it 'returns false' do
        self_array = array.all?(Float)
        expect(self_array).to be_falsey
      end
    end

    context 'If a block is given and all conditions pass' do
      it 'returns true' do
        self_array = array.all? do |num|
          num > 0
        end
        expect(self_array).to be_truthy
      end
    end

    context 'If a block is given and all conditions donot pass' do
      it 'returns false' do
        self_array = array.all? do |num|
          num > 4
        end
        expect(self_array).to be_falsey
      end
    end
  end
end
