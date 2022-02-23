def substrings(text, dictionary)
    result = {}

    lowered_text = text.downcase
    dict_str = dictionary.join(" ")
    dict_str_lowcase = dict_str.downcase

    dictionary.each do |word|
        matches = lowered_text.scan(word).size
        if matches != 0
            result[word] = matches
        end
    end

    return result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)