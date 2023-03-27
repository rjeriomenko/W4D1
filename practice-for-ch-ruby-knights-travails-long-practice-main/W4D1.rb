require_relative "tree_node"

class KnightPathFinder
    def initialize(pos)
        @pos = pos
        @considered_positions = Set.new
        @considered_positions.add(@pos)
        @root_node = PolyTreeNode.new(@pos)
        build_move_tree(root_node)# subject to change
    end

    def build_move_tree(node) # change
    end

    def self.valid_moves(pos)
        possible = []
        #4,4

        #code
    end

    def new_move_position(pos)
        KnightPathFinder.valid_moves(pos)
    end


        


end