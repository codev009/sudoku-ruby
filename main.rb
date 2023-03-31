class SudokuPuzzle
  def initialize(board)
    @board = board
  end

  attr_reader :board

  BOX_BOUNDS = {
    0 => [0, 1, 2],
    1 => [0, 1, 2],
    2 => [0, 1, 2],
    3 => [3, 4, 5],
    4 => [3, 4, 5],
    5 => [3, 4, 5],
    6 => [6, 7, 8],
    7 => [6, 7, 8],
    8 => [6, 7, 8]
  }.freeze

  def solve!
    while !complete?
      @board.each_with_index do |row, row_index|
        row.each_with_index do |number, number_index|
          if number.zero?
              # get the list of all already listed values (horizontal, vertical, 3x3 box)
              # get the list of all potential values
              # if there is only oen potential value, that value must belong in that box
              # if not, then we can't speculate, so we must move onto the next box
              # repeat over and over until all of the zeros are gone

            horizontal_values = row
            vertical_values = board.map { |board_row| board_row[number_index] }
            box_values = box_values(row_index, number_index) 

            all_values = (horizontal_values + vertical_values + box_values).reject(&:zero?).uniq
            potential_values = (1..9).to_a - all_values
            if potential_values.size == 1
              row[number_index] = potential_values.first
            end
          end
        end
      end
    end
  end

  def complete?
    board.flatten.none?(&:zero?)
  end

  private

  # 3x3 box
  def box_values(row_index, number_index)
    row_indexes = BOX_BOUNDS[row_index]
    number_indexs = BOX_BOUNDS[number_index]

    values = []

    row_indexes.each do |r_index|
      number_indexs.each do |n_index|
        values << board[r_index][n_index]
      end
    end

    values
  end
end

board = [
  [0, 0, 0, 0, 0, 0, 3, 0, 0],
  [7, 5, 0, 0, 8, 4, 0, 9, 6],
  [2, 0, 0, 0, 0, 6, 0, 0, 5],
  [0, 0, 4, 0, 0, 8, 0, 6, 0],
  [0, 0, 2, 4, 1, 5, 0, 7, 0],
  [0, 0, 5, 7, 0, 0, 0, 0, 0],
  [5, 3, 1, 6, 7, 0, 0, 0, 4],
  [6, 0, 9, 0, 3, 0, 2, 5, 7],
  [8, 0, 0, 5, 4, 9, 6, 0, 3]
]

puzzle = SudokuPuzzle.new(board)
puzzle.solve!
pp puzzle.board
