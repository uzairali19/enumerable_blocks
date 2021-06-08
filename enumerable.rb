# rubocop:disable Style/GuardClause
# rubocop:disable Style/RedundantSelf
# rubocop:disable Lint/DuplicateBranch
# rubocop:disable Style/IdenticalConditionalBranches
module Enumerable
  def my_each
    if block_given?
      to_a.length.times { |i| yield to_a[i] }
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      to_a.size.times { |i| yield to_a[i], i }
    else
      to_enum
    end
  end

  def my_select(&block)
    result = []
    my_each do |i|
      result << i if block.call(i) == true
    end
    result
  end

  def my_all?(&block)
    my_each do |i|
      if block.call(i) == true
        return true
      elsif block_given? == false
        return false
      elsif block_given? == true
        return true
      else
        return false
      end
    end
  end

  def my_any?(&block)
    my_each do |i|
      if block.call(i) == true
        return true
      elsif block_given? == true
        return true
      elsif block_given? == false
        return false
      else
        return false
      end
    end
  end

  def my_none?(&block)
    my_each do |i|
      if block.call(i) == true
        return false
      elsif block_given? == false
        return true
      elsif block_given? == true
        return false
      else
        return true
      end
    end
  end

  def my_count
    count = 0
    if self.length >= count
      self.my_each do
        count += 1
      end
    end
    count
  end

  def my_map(&block)
    result = []
    if block_given?
      self.my_each do |i|
        result << block.call(i)
      end
    else
      result = self
    end
    result
  end

  def my_inject(num = nil)
    if num.nil?
      total = self[0]
      self.my_each do |i|
        total = yield(total, i)
      end
    else
      total = num
      self.my_each do |i|
        total = yield(total, i)
      end
    end
  end
end

# rubocop:enable Style/GuardClause
# rubocop:enable Style/RedundantSelf
# rubocop:enable Lint/DuplicateBranch
# rubocop:enable Style/IdenticalConditionalBranches

def multiple_els(arr)
  arr.my_inject { |total, i| total * i }
end
