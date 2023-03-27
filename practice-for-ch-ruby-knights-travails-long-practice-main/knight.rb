require_relative "tree_node"

class KnightPathFinder
    # attr_reader :pos
    def initialize(pos)
        @pos = pos
        @considered_positions = Set.new # necessary?
        @considered_positions.add([5,1])
        @considered_positions.add(@pos)
        @root_node = PolyTreeNode.new(@pos)  # Start by creating an instance variable, `self.root_node` that stores the knight's initial position in an instance of your `PolyTreeNode` class.
        build_move_tree # subject to change
    end

    def build_move_tree # the root node of the tree should be the knight's starting position

        starting_moves = self.new_move_position(@root_node.value) 
        queue = [] 

        starting_moves.each do |pos|
            node = PolyTreeNode.new(pos) 
            @root_node.add_child(node)
            queue << node 
        end
        
        until queue.empty? 
            next_node = queue.shift 
            next_node_moves = self.new_move_position(next_node.value)
            next_node_moves.each do |move|
                child_node = PolyTreeNode.new(move)
                next_node.add_child(child_node)
                queue.push(child_node)
            end
        end 
    end

    def self.valid_moves(pos) #assuming the pos is positive
        possible = []
        pos_1 , pos_2 = pos
        (pos_1-2..pos_1+2).each do |pos1|
            (pos_2-2..pos_2+2).each do |pos2|
                possible_pair = [pos1, pos2]
                diff1 = pos1 - pos_1 
                diff2 = pos2 - pos_2  
                diff_sum = diff1 + diff2
                values = [3,-3,1,-1]
               
                if values.include?(diff_sum)
                    possible << possible_pair 
                end 
            end 
        end
        
        filtered_pairs = possible.select do |ele|
            pos1, pos2 = ele
            if (0..7).include?(pos1) && (0..7).include?(pos2)
                if [1, -1].include?(pos1 - pos_1)
                    pos2 - pos_2 != 0
                elsif [1,-1].include?(pos2 - pos_2)
                    pos1 - pos_1 != 0
                end
            end
        end

        filtered_pairs
    end

    def new_move_position(pos)  #pos is starting position before move
        possible_moves = KnightPathFinder.valid_moves(pos)
        
        unconsidered_positions = possible_moves.select do |pair|
            !@considered_positions.include?(pair)
        end

        @considered_positions.merge(unconsidered_positions)
        unconsidered_positions
    end   

    


end

p KnightPathFinder.valid_moves([3,2])

p k = KnightPathFinder.new([3,2])

# p k.new_move_position(k.pos)
