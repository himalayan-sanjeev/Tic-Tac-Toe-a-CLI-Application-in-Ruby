# Tic Tac Toe,a Ruby CLI Application

class Tictactoe
    # '$' represents global variables, '@':instance, valid inside an object
    $boards = [[" "," "," "],[" "," "," "],[" "," "," "]]
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
                print " | "
            end
            puts ""
            puts "-----------"
        end
        puts "\n"
    end

    # Take Input Position From Users
    def user_input(player)
        unless is_game_finished
            puts "Turn : Player #{player}\nEnter your input position:"
            pos = gets.chomp.to_i
            return pos
        else
            puts "Game Draw.Play Again?"
        end
    end

    # Check User Turns
    def user_turn
        player = $turn % 2 == 0 ? "X" : "O"
            unless is_game_finished
                if !check_winner
                        if (1..9).include?(pos=user_input(player))
                            if check_if_position_is_empty(pos)
                                row,col = boardPostion(pos)
                                $boards[row][col] = player
                                show_board
                                $turn+=1
                                user_turn
                            else
                                puts "This field is already filled! \nSelect an Empty field."
                                user_turn
                            end
                        else
                            puts "Invalid Input! \nEnter a valid position between 1 and 9."
                            show_board
                            user_turn
                        end
                else
                    winner = $turn % 2 == 0 ? "O" : "X"
                    puts "Congratulations!!\nPlayer #{winner} wins the game."
                end
            else
                if check_winner
                    winner = $turn % 2 == 0 ? "O" : "X"
                    puts "Congratulations!!\nPlayer #{winner} wins the game."
                else
                    puts "Game Draw!!\n Play it Again!!"
                end
            end
    end

    # Locate the Position of User Input in the Game Board
    def boardPostion(pos)
        if(1..3).include?pos
            row = 0
            col = (pos %3) - 1
        elsif (4..6).include?pos
            row = 1
            col = pos%3 == 0 ?  2 : ((pos%3) - 1)
        else
            row = 2
            col = pos%3 == 0 ?  2 : ((pos%3) - 1)
        end
        return row,col
    end

    # Check if the Field/Position Entered the User is Empty or not ?
    def check_if_position_is_empty(pos)
        row,col = boardPostion(pos)
        return $boards[row][col] == " " ? true : false
    end

    # Check if the Game is finished [if all the positions or board is filled or not]
    def is_game_finished
        $boards.flatten.include?(" ") ? false : true
    end

    # Checking Winner [ Fields are equal if the length of unique items in array is equal to 1 / i.e.unique items are only present in a row,column or diagonal ]
    def check_winner
        win = 0
        for i in (0..2)
            if !$boards[i].include?(" ") && $boards[i].uniq.length == 1
                win += 1
            end

            if !$boards.transpose[i].include?(" ") && $boards.transpose[i].uniq.length == 1
                win += 1
            end  
            
            if !$boards[i].include?(" ") && [$boards[0][0],$boards[1][1],$boards[2][2]].uniq.length == 1
                win += 1
            end

            if !$boards[i].include?(" ") && [$boards[0][2],$boards[1][1],$boards[2][0]].uniq.length == 1
                win += 1
            end
        end
        return win > 0 ? true : false
    end

end

# Instantiating the class
puts "##################################################"
puts "      Welcome to the Game of Tic Tac Toe!\n"
puts "##################################################"
puts "[ Select an Empty field position numbered from 1 to 9]\n "
Tictactoe.new
