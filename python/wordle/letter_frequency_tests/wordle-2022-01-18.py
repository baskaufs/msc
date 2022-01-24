import urllib.request
import json
import csv
from math import sqrt

# Global variables.
lowercase = 'abcdefghijklmnopqrstuvwxyz'
uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
number_all_words = 2529 # based on five-letter words from wordlist "6 of 12". See http://wordlist.aspell.net/12dicts-readme/#nof12

# ---------
# Functions
# ---------

def sort_funct(row):
    """Specify key to sort by. Return the value to sort."""
    return row['value']

# write the data to a file
def writeToFile(tableFileName, fieldnames, tableData):
    with open(tableFileName, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for writeRowNumber in range(0, len(tableData)):
            writer.writerow(tableData[writeRowNumber])

def generate_guess_code(guessed_word, actual_word):
    """Generate code required for input. Return a string of comma-separated values."""
    code = ['', '', '', '', '']
    non_positioned_letters_actual = []
    
    # Place codes for correct letters in correct positions
    for position in range(5):
        if actual_word[position] == guessed_word[position]:
            code[position] = actual_word[position].upper()
        else:
            non_positioned_letters_actual.append(actual_word[position])
    
    # Place codes for other letters
    for position in range(5):
        if code[position] == '': # Skip correct positioned letters
            if guessed_word[position] in non_positioned_letters_actual: # a guessed letter is in the word
                code[position] = guessed_word[position]
                # Need to remove letter in case it occurs in the word a second time
                non_positioned_letters_actual.remove(guessed_word[position])
            else:
                code[position] = '-' + guessed_word[position]
                
    code_string = ",".join(code)
    return(code_string)

def score_words_by_frequency(overall_weight, position_weight, switchover, wordle):
    """Generate a score for a word based on rank of letter frequencies. Return a list of dicts."""
    # Create list of ordinal dictionaries by position
    position_ordinals = []
    for position in range(5):
        position_ordinals.append(wordle.ordinals(position))
    overall_ordinals = wordle.ordinals()
       
    # Scale the weights depending on what fraction of the words are left to determine.
    # For all words, scaled_overall_weight = overall_weight and scaled_position_weight = position_weight
    # For two words, scaled_overall_weight = 0 and scaled_position_weight = 1. The penalty should go away
    # with two words because they will always be equally likely.

    # Add numeric override to increasing position weight
    if wordle.n < switchover:

        fraction_words_remaining = (wordle.n - 2) / (number_all_words)
        # NOTE: after experimentation, doing a linear scaling seems to phase out the overall weight too early,
        # particularly when it gets to the range of 20 to 100 words. 
        # I tried using part of a circle with radius of 1 as a different function, but it's performance was worse.
        # So I went back to the original, simpler method.
        '''
        try: # Trap negatives for very small numbers of words
            scaled_overall_weight = sqrt(1 - (1 - fraction_words_remaining)**2) * overall_weight
        except:
            scaled_overall_weight = 0
        '''
        # Scaling based on linear phaseout
        scaled_overall_weight = fraction_words_remaining * overall_weight
        scaled_position_weight = 1 - scaled_overall_weight
        #print('scaled_position_weight:', scaled_position_weight)
        #print('scaled_overall_weight:', scaled_overall_weight)

    else:
        scaled_overall_weight = overall_weight
        scaled_position_weight = position_weight
            
    # Calculate scores for all words
    score_list = []
    for word in wordle.wordlist:
        position_score = 0
        for position in range(5):
            position_score += position_ordinals[position][word[position]]
            
        unique_letters_list = list(dict.fromkeys(list(word)))
        overall_score = 0
        for unique_letter in unique_letters_list:
            overall_score += overall_ordinals[unique_letter]
        # Add penalty for not using all possible positions. 
        # Not using a position is worse than guessing the least frequent letter
        for penalty in range(5-len(unique_letters_list)):
            overall_score += 26
            
        score_list.append({'word': word, 'value': overall_score * scaled_overall_weight + position_score * scaled_position_weight})
    score_list.sort(key = sort_funct)
    
    return score_list

def calculate_frequency(position, word_list):
    """Determine the frequencies of letters by position in word (0 to 4). Return a tuple with descending ordered list of letter frequencies and dictionary with letter keys."""
    freq_list = []
    freq_dict = {}
    for letter in lowercase:
        frequency = 0
        for word in word_list:
            if letter == word[position]:
                frequency += 1
        freq_list.append({'letter': letter, 'value': frequency})
        freq_dict[letter] = frequency
    freq_list.sort(key = sort_funct, reverse=True)
    return freq_list, freq_dict
    
def calculate_total_frequency(wordlist):
    freq_dict = {}
    for letter in lowercase:
        freq_dict[letter] = 0

    # Add up the frequencies for each position
    for pos in range(5):
        dummy, temp_dict = calculate_frequency(pos, wordlist)
        for letter in lowercase:
            freq_dict[letter] += temp_dict[letter]

    # Create the list of frequencies
    freq_list = []
    for letter in lowercase:
        freq_list.append({'letter': letter, 'value': freq_dict[letter]})
    freq_list.sort(key = sort_funct, reverse=True)
    return freq_list, freq_dict

# ---------
# Classes
# ---------

class Wordle_list():
    """Represents a screened list of words that may have been screened after a guess.
    
    Methods:
    - frequencies  Optional argument specifying the position within the word. If omitted, frequencies are for all positions.
    - ordinals  Optional argument specifying the position within the word. If omitted, ordinals are for all positions.
    
    Instance variables:
    - n  Number of words in the list
    - wordlist  A list containing the words after applying a screen based on the guess code parameter.
    - unique  A list derived from the wordlist by filtering for unique words.
    """
    
    def __init__(self, **kwargs):
        """Instantiate a screened list of words.
        
        Arguments:
        - wordlist  A list containing words to be screened. If omitted, the original curated list of English words is used.
        - guess  A string of codes separated by commas indicating the results of a guess. If omitted or malformed, no screening is carried out on the list.
        """
        
        try:
            self.wordlist = kwargs['wordlist']
        except:
            # List of 5698 five-letter words extracted from 100000 common English words. Was mising some common words
            #url = 'https://gist.githubusercontent.com/baskaufs/d43301918b5fc2583ef884d6014c25d4/raw/b0b02c703f7bd361c5e32c0a2f1eba39d075b0b1/five_letter.txt'
            # Alternate file from https://www.wordgamedictionary.com/word-lists/5-letter-words/5-letter-words.json
            #url = 'https://gist.githubusercontent.com/baskaufs/aa458449891fe4d36e51b87c8f8d58c7/raw/b23c349ab83e1098782208f4eb08ee949c4a89e7/five_letter.txt'
            
            # The 6 of 12 list is a high-quality curated list of American English words. Capitalization is consistent
            # and abbreviations are marked so they can be removed. The number of extracted words is similar to the number
            # that Wordle said he used (about 2500). So this seems about right. http://wordlist.aspell.net/12dicts-readme/#nof12
            url = 'https://gist.github.com/baskaufs/8c5f187e41f37af7e395c7094eb796d8/raw/cc40500c0ecc7b4e33dedf96451d26ef6362af2b/five_letter_6of12.txt'           
            file_object = urllib.request.urlopen(url)
            self.wordlist = file_object.read().decode('utf-8').split('\n')[:-1] # need to get rid of empty string caused by trailing newline

        # Use guess information to screen out words from wordlist
        try:
        #if True:
            # Guess is a string with position guesses separated by commas. 
            # Uppercase letters are correct letter, correct position
            # Lowercase letters are correct letter, incorrect position
            # Lowercase letters with prepended minus are letters not in word.
            guess_string = kwargs['guess']
            guess_list = guess_string.split(',')
            
            # First need to limit to words with letters with newly discovered positions.
            for position in range(5):
                if guess_list[position][0] in uppercase:
                    # No screening necessary if position already known because screening was done before
                    if not position_known[position]:
                        known_letter = guess_list[position][0].lower()
                        new_list = []
                        for word in self.wordlist:
                            if word[position] == known_letter:
                                new_list.append(word)
                        self.wordlist = new_list
                        position_known[position] = True
                        
                        # If this letter was previously known to have been in the word, 
                        # decrease the number of that letter known to be in the word by one
                        if letters_in[known_letter] > 0:
                            letters_in[known_letter] -= 1
            #print('wordlist after restricting to words with letters in right positions:', self.wordlist)
            #print()
                            
            # Eliminate words that don't have enough of the known letters in incorrect positions
            # First need to find out what information about known letters is in this guess
            new_letters_in = {}
            for letter in lowercase:
                new_letters_in[letter] = 0
            # Find the total number of each letter in the incorrect positions information from this guess
            for position in range(5):
                if guess_list[position][0] in lowercase:
                    new_letters_in[guess_list[position][0]] += 1
            # Update the dictionary of known letters
            for letter in lowercase:
                if letters_in[letter] < new_letters_in[letter]:
                    letters_in[letter] = new_letters_in[letter]
            # Now screen the wordlist for only words that have enough of each known letter in unknown positions
            new_list = list(self.wordlist) # apply list conversion function to make a copy of the wordlist
            for word in self.wordlist:
                remove = False
                for letter in lowercase:
                    if letters_in[letter] > 0: # Apply the screen only if something is known about that letter
                        # Count the number of times that the letter is in the remaining unknown positions of the word
                        letter_count = 0
                        for position in range(5):
                            if word[position] == letter and not(position_known[position]):
                                letter_count += 1
                        if letter_count < letters_in[letter]:
                            remove = True
                            continue
                if remove:
                    new_list.remove(word)
            self.wordlist = new_list
            #print('wordlist after removing words without known letters:', self.wordlist)
            #print()
            
            # We also have to eliminate any words that have the new known but incorrectly positioned letter 
            # in the position where it was guessed
            for position in range(5):
                if guess_list[position][0] in lowercase:
                    new_list = list(self.wordlist)
                    for word in self.wordlist:
                        if word[position] == guess_list[position][0]:
                            new_list.remove(word)
                    self.wordlist = new_list
            #print('wordlist after removing words with known letter in guessed position:', self.wordlist)
            #print()                    
                        
            # Eliminate words that contain letters known to not be in the word
            for position in range(5):
                if guess_list[position][0] == '-': # incorrect letter marker
                    incorrect_letter = guess_list[position][1].lower()
                    # Only screen if it's a new one; this won't happen if play is without mistakes
                    if not incorrect_letter in letters_out:
                        # Need to check for the special case where the same letter was guessed in an earlier position
                        # in the word and was identified as present (but not in the correct position). In that case,
                        # the second (incorrect) guess must not trigger addition to the letters_out list, as that would
                        # result in the incorrect screening out of all words containing that letter.
                        # NOTE: Correct operation of this test depends on the first occurrence of that letter in a guess
                        # word being scored as present and the second occurrence being scored as absent. I haven't
                        # tested this with the real app to see if this is actually the behavior.
                        if letters_in[incorrect_letter] == 0: 
                            letters_out.append(incorrect_letter)
                            # Remove any words that have that letter in unknown positions
                            new_list = list(self.wordlist)
                            for word in self.wordlist:
                                remove = False
                                for position in range(5): # set to remove if letter occurs any number of times
                                    if word[position] == incorrect_letter and not(position_known[position]):
                                        remove = True
                                if remove:
                                    new_list.remove(word)
                            self.wordlist = new_list

            #print('wordlist after removing words with incorrect letters:', self.wordlist)
            #print()

        except:
            # Don't do any screening if there isn't a guess or guess string is malformed
            #print('No screen applied.')
            pass
        
        # Create list of words with unique letters in unknown positions
        unique_letter_words = []
        for word in self.wordlist:
            letter_list = []
            # Check each letter in the word and add to list if it's in a position that isn't yet known.
            for position in range(5):
                if not position_known[position]:
                    letter_list.append(word[position])
            unique_letter_list = list(dict.fromkeys(letter_list))
            if len(unique_letter_list) == len(letter_list):
                unique_letter_words.append(word)
        self.unique = unique_letter_words
        
        self.n = len(self.wordlist)

    def frequencies(self, position=-1):
        """Calculate frequencies by position, or of all letters if position omitted. Return a tuple with descending ordered list of letter frequencies and dictionary with letter keys."""
        # If a position is given, just return the frequencies for that position directly
        if position >= 0:
            freq_list, freq_dict = calculate_frequency(position, self.wordlist)
            
        # Calculate frequencies for the whole words
        else:
            freq_list, freq_dict = calculate_total_frequency(self.wordlist)

        return freq_list, freq_dict
    
    def ordinals(self, position=-1):
        """Determine ordinals for letters by position, or of all letters if position omitted. Return a dictionary with letter keys."""
        # If a position is given, just return the frequencies for that position only
        if position >= 0:
            freq_list = calculate_frequency(position, self.wordlist)[0]
        else:
            freq_list = calculate_total_frequency(self.wordlist)[0]
            
        # Need to give the same ordinal number to letters with the same frequency
        ordinal_of_last_letter = 0
        frequency_of_last_letter = -1
        ordinal_dict = {}
        for letter_freq_number in range(26):
            if freq_list[letter_freq_number]['value'] == frequency_of_last_letter:
                ordinal_dict[freq_list[letter_freq_number]['letter']] = ordinal_of_last_letter
            else:
                ordinal_dict[freq_list[letter_freq_number]['letter']] = letter_freq_number
                frequency_of_last_letter = freq_list[letter_freq_number]['value']
                ordinal_of_last_letter = letter_freq_number

        return ordinal_dict

def all_scores_same(score_list):
    # Don't bother checking if there are more than five scores
    if len(score_list) > 5:
        return False
    all_same = True
    for score in score_list[1:]:
        if score['value'] != score_list[0]['value']:
            all_same = False
    return all_same

# Start of main script

# Reset mutable global variables (required for generating initial Wordle list)
letters_in = {}
for letter in lowercase:
    letters_in[letter] = 0

letters_out = []

unknown_letters = []
for letter in lowercase:
    unknown_letters.append(letter)
    
position_known = []
for position in range(5):
    position_known.append(False)

# Instantiate initial Wordle_list object
start = Wordle_list()

# Initial setup
fixed_first_word = 'caret'
overall_weight = 0.6
position_weight = 1 - overall_weight
switchover = 11

# Generate ordered list of first guess words to test
test_words_dicts = score_words_by_frequency(overall_weight, position_weight, switchover, start)

results_list = []
for dict_number in range(len(test_words_dicts)-10, len(test_words_dicts)):
#for dict in test_words_dicts[-10:]:
    fixed_first_word = test_words_dicts[dict_number]['word']

    score_sum = 0
    word_count = 0
    answer_frequencies = []
    for index in range(12):
        answer_frequencies.append(0)
    losing_words = []

    for actual_word in start.wordlist:

        # Reset mutable global variables
        letters_in = {}
        for letter in lowercase:
            letters_in[letter] = 0

        letters_out = []

        unknown_letters = []
        for letter in lowercase:
            unknown_letters.append(letter)
            
        position_known = []
        for position in range(5):
            position_known.append(False)
            
        next_guess_code = generate_guess_code(fixed_first_word, actual_word)
        next_wordle_list = Wordle_list(guess=next_guess_code, wordlist=start.wordlist)

        # Default the number of additional turns to one for case where screening results in only one possible word, but it must be guessed.
        # This is the normal while loop termination situation.
        additional_turns_required = 1
        guess_number = 1

        # Handle edge case where the word is the original guess word
        if fixed_first_word == actual_word:
            words_remaining = 1
            guess_number = 0 # need to set this since one will be added at the end
        else:
            words_remaining = next_wordle_list.n

        while words_remaining > 1:
            guess_number += 1
            score_list = score_words_by_frequency(overall_weight, position_weight, switchover, next_wordle_list)

            '''
            # Handle the case where there are more than one word with equal scores. Not sure if it will ever be more than 3.
            # Since counter already incremented, the required guess is already accounted for.
            if all_scores_same(score_list):
                print('calc', score_list)
                additional_turns_required = (len(score_list) - 1) / 2
                print(additional_turns_required)
                break
            '''

            next_guess_word = score_list[0]['word']
            #print('word', guess_number, '=', next_guess_word, ' Possible words:', words_remaining)

            # Lucky guess contingency: the top screening word is the word. Quit the loop and add default one turn for the guess without incrementing.
            if next_guess_word == actual_word:
                additional_turns_required = 0
                #print('lucky guess')
                break

            next_guess_code = generate_guess_code(next_guess_word, actual_word)
            next_wordle_list = Wordle_list(guess=next_guess_code, wordlist=next_wordle_list.wordlist)
            words_remaining = next_wordle_list.n

        #print('Answer:', actual_word, ' Guesses:', guess_number + additional_turns_required)
        #print()
        score = guess_number + additional_turns_required
        score_sum += score
        word_count += 1
        #print(word_count)
        answer_frequencies[score] += 1
        #print(answer_frequencies)
        if score > 6:
            losing_words.append({'word': actual_word, 'score': score})
        #print()

    print(dict_number)
    print(fixed_first_word, test_words_dicts[dict_number]['value'])
    print(overall_weight)
    print(score_sum/word_count)
    print(answer_frequencies)
    #print(losing_words)
    print()
    results_list.append({'first_word': fixed_first_word, 'ranking': test_words_dicts[dict_number]['value'], 'overall_weight': overall_weight, 'ave_score': score_sum/word_count, 'answer_freq': json.dumps(answer_frequencies)})
    fieldnames = ['first_word', 'ranking', 'overall_weight', 'ave_score', 'answer_freq']
    writeToFile('wordle_test_results.csv', fieldnames, results_list)