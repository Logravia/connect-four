# lib/display.rb

class Display

  def game(state, msg=nil)
    clear
    message(msg)
    space
    print_token_grid(state)
    line
    numbers
    space
  end

  def print_token_grid(state)
    state.each do |row|
      row.each do |column|
        if column.nil?
          print "[ ]"
        else
          print "[#{column}]"
        end
      end
      puts ""
    end
  end

  def numbers
    puts " 1  2  3  4  5  6  7"
  end

  def line
    puts '---------------------'
  end

  def space
    puts ""
  end

  def message(msg)
    return if msg.nil?
    hash_cover(msg)
    puts "#  #{msg}  #"
    hash_cover(msg)
  end

  def hash_cover(msg)
    print '###'
    msg.chars.each do |_char|
      print '#'
    end
    puts "###"
  end

  def clear
    puts "\e[H\e[2J"
  end

end
