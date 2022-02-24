def stock_picker(array)
    final_profit = 0
    day1 = 0
    day2 = 0

    array.each_with_index do |value, index|
        for i in index + 1 .. array.size - 1 do
            profit = array[i] - value
            if profit > final_profit
                final_profit = profit
                day1 = index
                day2 = i
            end
        end
    end
    p [day1, day2]
end

stock_picker([17,3,6,9,15,8,6,1,10])