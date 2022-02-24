def bubble_sort(array)
    for i in 1..array.length - 1 do
        for j in 1..array.length - 1 do
            if array[j-1] > array[j]
                temp = array[j-1]
                array[j-1] = array[j]
                array[j] = temp
            end
        end
        if array == array.sort
            break
        end
    end
    array
end

bubble_sort([4,3,78,2,0,2])