# frozen_string_literal: true

def merge_sort(array)
  if array.size < 2
    array
  else
    left = merge_sort(array[0...array.size / 2])
    right = merge_sort(array[array.size / 2...array.size])
    merge(left, right)
  end
end

def merge(left, right, array=[])
  (left.size + right.size).times do
    if left.empty?
      array << right.shift
    elsif right.empty?
      array << left.shift
    else
      comparison = left <=> right
      case comparison
      when 1
        array << right.shift
      when 2
        array << left.shift
      else
        array << left.shift
      end
    end
  end
  array
end

array = []
rand(100).times do
  array << rand(100)
end

p merge_sort(array)
