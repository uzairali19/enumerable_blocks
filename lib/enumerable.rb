# rubocop:disable Style/RedundantSelf
# rubocop:disable Metrics/MethodLength
# rubocop:disable Style/IdenticalConditionalBranches
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Lint/ToEnumArguments

module Enumerable
  def my_each(&block)
    if block_given?
      self.each(&block)
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      my_each { |e| yield(e, index(e)) }
    else
      to_enum
    end
  end

  def my_select
    result = []
    if block_given?
      self.my_each do |i|
        result << i if yield(i)
      end
    else
      to_enum
    end
    result
  end

  def my_all?(param = nil)
    result = false

    if block_given?
      self.to_a.my_each do |i|
        return result if yield(i) == false
      end
    elsif param.nil?
      self.to_a.my_each do |i|
        return result if i.nil? || i == false
      end
    elsif !param.nil? && (param.is_a? Class)
      self.to_a.my_each do |i|
        return result unless [i.class, i.class.superclass].include?(param)
      end
    elsif !param.nil? && param.instance_of?(Regexp)
      self.to_a.my_each do |i|
        return result unless param.match(i)
      end
    else
      self.to_a.my_each do |i|
        return result if i != param
      end
    end
    result = true
  end

  def my_any?(param = nil)
    result = true

    if block_given?
      self.to_a.my_each do |i|
        return result if yield(i) == true
      end
    elsif param.nil?
      self.to_a.my_each do |i|
        return result if i.nil? || i == false
      end
    elsif !param.nil? && (param.is_a? Class)
      self.to_a.my_each do |i|
        return result unless [i.class, i.class.superclass].include?(param)
      end
    elsif !param.nil? && param.instance_of?(Regexp)
      self.to_a.my_each do |i|
        return result if param.match(i)
      end
    else
      self.to_a.my_each do |i|
        return result if i != param
      end
    end
    result = false
  end

  def my_none?(param = nil)
    result = false

    if block_given?
      self.to_a.my_each do |i|
        return result if yield(i) == true
      end
    elsif param.nil?
      self.to_a.my_each do |i|
        return result if !i.nil? and !i == false
      end
    elsif !param.nil? && (param.is_a? Class)
      self.to_a.my_each do |i|
        return result if [i.class, i.class.superclass].include?(param)
      end
    elsif !param.nil? && param.instance_of?(Regexp)
      self.to_a.my_each do |i|
        return result if param.match(i)
      end
    else
      self.to_a.my_each do |i|
        return result if i != param
      end
    end
    result = true
  end

  def my_count(num = nil)
    count = 0
    if block_given?
      self.to_a.my_each do |i|
        count += 1 if yield(i)
      end
    elsif !block_given? && num.nil?
      count = self.to_a.length
    else
      count = self.to_a.my_select do |i|
        i == num
      end.length
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?

    result = []
    if proc.nil?
      self.my_each do |i|
        result << yield(i)
      end
    else
      self.my_each do |i|
        result << proc.call(i)
      end
    end
    result
  end

  def my_inject(num = nil)
    return to_enum(:my_inject) unless block_given?

    if num
      total = num
      self.my_each do |i|
        total = yield(total, i)
      end
      total
    else
      new_array = self.dup
      total = new_array.shift
      new_array.my_each do |i|
        total = yield(total, i)
      end
      total
    end
  end
end

# rubocop:enable Style/RedundantSelf
# rubocop:enable Metrics/MethodLength
# rubocop:enable Style/IdenticalConditionalBranches
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Lint/ToEnumArguments

def multiply_els(arr)
  arr.my_inject { |total, i| total * i }
end
