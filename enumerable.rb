# rubocop:disable Style/GuardClause
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

  def my_all(&block)
    my_each do |i|
      if block.call(i) == true
        return true
      else
        return false
      end
    end
  end
end

# rubocop:enable Style/GuardClause
