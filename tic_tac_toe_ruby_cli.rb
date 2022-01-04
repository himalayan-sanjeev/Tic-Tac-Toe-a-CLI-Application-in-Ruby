# frozen_string_literal: true

# Tic Tac Toe,a Ruby CLI Application
class Tictactoe
  # '$' represents global variables, '@':instance, valid inside an object
  $boards = [['', '', ''], ['', '', ''], ['', '', '']]
  $turn = 1

  # Main Method Runner
  def initialize
    show_board
    user_turn
  end

  # Display Game Board
  def show_board
    puts "\n"
    $boards.each do |board|
      board.each do |b|
        print b
        print ' | '
      end
      puts ''
      puts '-----------'
    end
    puts "\n"
  end

  # Take Input Position From Users
  def user_input(player)
    if game_finished?
      puts "Turn : Player #{player}\nEnter your input position:"
      gets.chomp.to_i
    else
      puts 'Game Draw.Play Again?'
    end
  end

  # Check User Turns
  def user_turn
    player = ($turn % 2).zero? ? 'X' : 'O'
    if game_finished?
      if check_winner
        winner = ($turn % 2).zero? ? 'O' : 'X'
        puts "Congratulations!!\nPlayer #{winner} wins the game."
      else
        if (1..9).include?(pos = user_input(player))
          user_turn
          if check_if_position_is_empty(pos)
            row, col = board_postion(pos)
            $boards[row][col] = player
            show_board
            $turn += 1
          else
            puts "This field is already filled! \nSelect an Empty field."
          end
        else
          puts "Invalid Input! \nEnter a valid position between 1 and 9."
          show_board
          user_turn
        end
      end
    else
      if check_winner
        winner = ($turn % 2).zero? ? 'O' : 'X'
        puts "Congratulations!!\nPlayer #{winner} wins the game."
      else
        puts "Game Draw!!\n Play it Again!!"
      end
    end
  end

  # Locate the Position of User Input in the Game Board
  def board_postion(pos)
    if (1..3).include? pos
      row = 0
      col = (pos % 3) - 1
    elsif (4..6).include? pos
      row = 1
      col = (pos % 3).zero? ? 2 : ((pos % 3) - 1)
    else
      row = 2
      col = (pos % 3).zero? ? 2 : ((pos % 3) - 1)
    end
    [row, col]
  end

  # Check if the Field/Position Entered the User is Empty or not ?
  def check_if_position_is_empty(pos)
    row, col = board_postion(pos)
    $boards[row][col] == ''
  end

  # Check if the Game is finished [if all the positions or board is filled or not]
  def game_finished?
    $boards.flatten.include?('')
  end

  # Checking Winner
  def check_winner
    win = 0
    [0, 1, 2].each do |i|
      # for i in (0..2)
      if (!$boards[i].include?('') && $boards[i].uniq.length == 1) ||
         (!$boards.transpose[i].include?('') && $boards.transpose[i].uniq.length == 1) ||
         (!$boards[i].include?('') && [$boards[0][0], $boards[1][1], $boards[2][2]].uniq.length == 1) ||
         (!$boards[i].include?('') && [$boards[0][2], $boards[1][1], $boards[2][0]].uniq.length == 1)
        win += 1
      end
    end
    win.positive?
  end
end

# Instantiating the class
puts '##################################################'
puts '      Welcome to the Game of Tic Tac Toe!\n'
puts '##################################################'
puts '[ Select an Empty field position numbered from 1 to 9]\n '
Tictactoe.new
