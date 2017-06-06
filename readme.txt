Problem Description: Given an arbitrary text document written in English, write a program that will generate a
concordance, i.e. an alphabetical list of all word occurrences, labeled with word frequencies.
Bonus: label each word with the sentence numbers in which each occurrence appeared.

To run have Ruby installed and use "ruby main.rb" on the command line in the directory of the unzipped folder. 
I spent about 2 and a half hours on the challenge including time spent refactoring.
The solution fails on documents exceeding around 8000 sentences due to Ruby recursion limitations 
which could be fixed by replacing the recursive_sentence_split function with a while loop.
I also included a copy some of my unedited code in extra.rb for a look at my development process. 