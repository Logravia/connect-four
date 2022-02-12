module Msg
  def self.invalid_column
    ['Wrong column. Choose columns 1-8.',
     'That ain\'t it, chief. Numbers 1 to 8.',
     'One number, one column. Press enter.',
     'Don\'t get fancy with me. Enter 1 or 8 or whatever.',
     'This ain\'t hard, you know, just pick a column',
     'There are 8 columns on the screen pick one.',
     'Press a number and then the enter key.',
     'Number. Enter. Boom. Token dropped. But no.'].sample
  end

  def self.invalid_token
    ['Choose a SINGLE symbol, please.',
     'Surely, you can count to one.',
     'Press L, then enter, cuz you\'re lame.',
     'Choose a symbol to represent you in the game',
     'Type a single letter then smack the enter key, please.',
     'Look, I don\'t have the whole day here. Type correctly.' ].sample
  end

  def self.column_full
    ['That column is full, try a different one',
     'That column is full, bucko.',
     'Try a different maybe column?',
     'Don\'t you see that column is full?',
     'Do you even know how to play this game?'].sample
  end

  def self.tie
    'Never seen such bad players.'
  end

  def self.victory
    'Congratulations! Shame on the other guy.'
  end

  def self.choose_token
    ['choose your token.',
     'pick your token.',
     'choose something to represent you.',
     'pick a symbol'].sample
  end

  def self.same_token
    ['Sorry, you chose the same token as player one',
     'Can\'t choose that',
     'That token belong to first player'].sample
  end

  def self.good_token
    ['That is a good token',
     'I like your choice',
     'Not a bad choice',
     'Nice, I like that',
     'Not too shabby',
     'Pretty cool token you got there',].sample
  end

  def self.choose_column
    ['Time to drop',
     'Pick a column and drop your',
     'Choose a column and drop',
     'One to seven, enter, drop that',
     'Pick a column,',
     'Select a column,',
     'Pick one number and enter,'].sample
  end

end
