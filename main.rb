# frozen_string_literal: true

# if element == 0
# end

class SudokuPuzzle
  def initialize(board)
    @board = board 
  end

  attr_reader :board

  def solve!
    while !complete?
      @board.each do |row|
        row.each_with_index do |number, index|
          if number.zero?
            row[index] = 1 # reasign
              # get the list of all already listed values
              # get the list of all potential values
              # if there is only oen potential value, that value must belong in that box
              # if not, then we can't speculate, so we must move onto the next box
              # repeat over and over until all of the zeros are gone
          end
        end
      end
    end
  end

  def complete?
    @board.flatten.none?(&:zero?)
  end
end

board = [
  [0, 0, 0, 0, 0, 0, 3, 0, 0],
  [7, 5, 0, 0, 8, 4, 0, 9, 6],
  [2, 0, 0, 0, 0, 6, 0, 0, 5],
  [0, 0, 4, 0, 0, 8, 0, 6, 0],
  [0, 0, 2, 4, 1, 5, 0, 7, 0],
  [0, 0, 5, 7, 0, 0, 3, 0, 0],
  [5, 3, 1, 6, 7, 0, 0, 0, 4],
  [6, 0, 9, 0, 3, 0, 2, 5, 7],
  [8, 0, 0, 5, 4, 9, 6, 0, 3]
]

puzzle = SudokuPuzzle.new(board)
puzzle.solve!
pp puzzle.board
