require_relative "tree_node"

class KnightPathFinder
    def initialize(pos)
        @pos = pos
        @considered_positions = Set.new
        @considered_positions.add(@pos)
        @root_node = PolyTreeNode.new(@pos)
        # build_move_tree(root_node)# subject to change
    end

    def build_move_tree(node) # change
    end

    def self.valid_moves(pos)
        possible = []
        pos_1 , pos_2 = pos
        (pos_1-2..pos_1+2).each do |pos1|
            (pos_2-2..pos_2+2).each do |pos2|
                possible_pair = [pos1, pos2]
                diff1 = pos1 - pos_1 
                diff2 = pos2 - pos_2  
                diff_sum = diff1 + diff2
                values = [3,-3,1,-1]
               
                if values.include?(diff_sum) && (![1, -1].include?(pos1 - pos_1) || ![1,-1].include?(pos2 - pos_2))
                # if values.include?(diff_sum) && (pos1 != pos_1 - 1 || pos1 != pos_1 + 1) && (pos2 != pos_2 - 1 || pos2 != pos_2 + 1)
                    possible << possible_pair 
                end 
            end 
        end
        
        p possible.select 
    end

    def new_move_position(pos)
        KnightPathFinder.valid_moves(pos)
    end


        


end