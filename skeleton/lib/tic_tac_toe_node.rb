require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent = evaluator == :o ? :x : :o
    if @board.over?
      return @board.winner == opponent
    end
    # children.all? { |child| child.winning_node?(opponent) }
    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)
    # opponent = evaluator == :o ? :x : :o
    # return true if @board.over? && @board.winner == evaluator
    if @board.over?
      return @board.winner == evaluator
    end
    # children.any? { |child| child.winning_node?(evaluator) }
    if @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end

  end

  def swap_mark
    @next_mover_mark == :o ?  :x : :o
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_arr = []
    @board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|

        pos = [row_idx, col_idx]
        next unless @board.empty?(pos)
        new_board = @board.dup
        new_board[pos] = @next_mover_mark
        new_node = TicTacToeNode.new(new_board, swap_mark, pos)
        children_arr << new_node
      end
    end
    children_arr
  end

end
