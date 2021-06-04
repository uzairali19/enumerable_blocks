module Enumerable
  def my_each
    if block_given?
      to_a.length.times { |i| yield to_a[i] }
    else
      to_enum
    end
  end
end
