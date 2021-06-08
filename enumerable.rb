# rubocop:disable Style/GuardClause
# rubocop:disable Style/RedundantSelf
# rubocop:disable Lint/DuplicateBranch
# rubocop:disable Lint/Syntax
# rubocop:disable Style/IdenticalConditionalBranches
module Enumerable
  def my_each
    if block_given?
      to_a.size.times { |i| yield to_a[i] }
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

  def my_select(&block)
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
    elsif !param.nil? && param.class == Regexp
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
    elsif !param.nil? && param.class == Regexp
      self.to_a.my_each do |i|
        return result unless !param.match(i)
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
    elsif !param.nil? && param.class == Regexp
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

  # def my_none?
  #   if block_given?
  #     self.my_each do |i|
  #       return false unless yield i
  #     end
  #   else
  #     self.my_each do |i|
  #       return true unless i
  #     end
  #   end
  #   false
  # end

  def my_count
    count = 0
    if self.size >= count
      self.my_each do
        count += 1
      end
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?

    result = []
    if proc != nil
      self.my_each do |i|
        result << proc.call(i)
      end
    else
      self.my_each do |i|
        result << yield(i)
      end
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
# rubocop:enable Lint/Syntax
# rubocop:enable Style/IdenticalConditionalBranches

def multiple_els(arr)
  arr.my_inject { |total, i| total * i }
end
