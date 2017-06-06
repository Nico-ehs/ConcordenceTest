# Problem Description: Given an arbitrary text document written in English, write a program that will generate a
# concordance, i.e. an alphabetical list of all word occurrences, labeled with word frequencies.
# Bonus: label each word with the sentence numbers in which each occurrence appeared.
# To run have Ruby installed and use "ruby main.rb" on the command line.

class Concordence
    
    def initialize(text)
        #
        @text=text
        by_sentence
        word_list
    end
    
    def by_sentence
        # Creates a 2-layer list of the words in each sentence.
        @sentences=recursive_sentence_split(@text).map {|sentence| sentence.downcase.gsub(/[^a-z \.\'\-]/, '').split(" ")}
    end
    
    def recursive_sentence_split(string)
        # Spits a sentence into it's compent words.
        return [string.chomp(".")] unless string.index(/\.\s[A-Z]/)
        [string[0...string.index(/\.\s[A-Z]/)]] + recursive_sentence_split(string[(string.index(/\.\s[A-Z]/)+2)..-1])
    end
    
    def word_list
        # creates a wordlist hash with the count and sentence number(s) for each word
        @word_count=Hash.new([])
        @sentences.each.with_index {|sentence, number| sentence.each{|word| @word_count[word.downcase]+=[number+1]}}
    end
    
    def output
        # Returns the concordence list.
        ((@word_count.keys.sort).map.with_index  {|word, word_number| output_format(word, @word_count[word], word_number)}).join(" ")
    end
    
    def output_format(word, count, word_number)
        # formats the output to the test sample.
        lable(word_number)+word+" {#{count.size}:#{count.join(",")}}"
    end
    
    def lable(number)
        # creates a labal based on the test output format
        (("a".."z").to_a)[number%26]*(1+number/26)+". "
    end
    
end

def concordence_test
    raw_data=File.read("test.txt").split("\n")
    test_input=raw_data[0..2].join(" ")
    goal=raw_data[3..-1].join(" ")
    goal==Concordence.new(test_input).output
end

print "Output matches test: " + concordence_test.to_s + "\n"
