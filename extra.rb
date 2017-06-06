class Concordence
    
    def initialize(text)
        @text=text
        by_sentence
        word_list
    end
    
    def by_sentence
        # @sentences=@text.split(". ")
        # @sentences=@text.split(%r{\.\s[A-Z]})
        # # print @sentences
        # @sentences[-1].chomp!(".")
        # print @text.index(/\.\s[A-Z]/).to_s + "\n"
        @sentences=recursive_sentence_split(@text).map {|sentence| sentence.downcase.gsub(/[^a-z \.\'\-]/, '').split(" ")}
        # print "\n\n"
        # print @sentences
        # print "\n\n"
        
    end
    
    def recursive_sentence_split(string)
        return [string.chomp(".")] unless string.index(/\.\s[A-Z]/)
        [string[0...string.index(/\.\s[A-Z]/)]] + recursive_sentence_split(string[(string.index(/\.\s[A-Z]/)+2)..-1])
    end
    
    def word_list
        @word_count=Hash.new([])
        @sentences.each.with_index {|sentence, number| sentence.each{|word| @word_count[word.downcase]+=[number+1]}}
    end
    
    def output
        # output=""
        # print "\n"+@word_count.keys.sort.to_s+"\n"
        # (@word_count.keys.sort).each.with_index  {|word, word_number| output+=output_format(word, @word_count[word], word_number)}
        ((@word_count.keys.sort).map.with_index  {|word, word_number| output_format(word, @word_count[word], word_number)}).join(" ")
        # output
    end
    
    def output_format(word, count, word_number)
        lable(word_number)+word+" {#{count.size}:#{count.join(",")}}"
    end
    
    def lable(number)
        (("a".."z").to_a)[number%26]*(1+number/26)+". "
    end
    
end



def concordence_test
    raw_data=File.read("test.txt").split("\n")
    test_input=raw_data[0..2].join(" ")
    goal=raw_data[3..-1].join(" ")
    # print Concordence.new(test_input).output[0..400]
    # print "\n\n"
    # print goal[0..400]
    # print "\n\n"
    return true if goal==Concordence.new(test_input).output
    false
end

# concordence_test

print "Output matches test: " + concordence_test.to_s + "\n"
