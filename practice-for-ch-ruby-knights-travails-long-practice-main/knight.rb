require_relative "tree_node"

class KnightPathFinder
    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = Set.new # necessary?
        @considered_positions.add(@start_pos)
        @root_node = PolyTreeNode.new(@start_pos)  # Start by creating an instance variable, `self.root_node` that stores the knight's initial position in an instance of your `PolyTreeNode` class.
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

    #render methods

    def print_children
        puts "Root layer -----------------------"
        puts "Root node: #{@root_node.value}"
        child_positions = @root_node.children.map { |child_node| child_node.value }
        
        puts "Root children: #{child_positions}"

        layer = 0
        print_queue = @root_node.children

        until print_queue.empty?
            puts
            first_printable = print_queue.shift

            if depth(first_printable) > layer
                layer = depth(first_printable)
                puts "Layer #{layer} -----------------------\n\n"
            end
            puts "Node: #{first_printable.value}"
            first_printable_children = first_printable.children.map {|child| child.value}
            puts "Node children: #{first_printable_children}"
            print_queue += first_printable.children
            puts "Node depth: #{depth(first_printable)}"
        end
    end

    def depth(node)
        return 0 if node == @root_node
        return 1 if node.parent == @root_node

        1 + depth(node.parent)
    end

    def print_chessboard_with_considered_positions
        grid = Array.new(8) {Array.new(8, [])}

        @considered_positions.each do |pos|
            pos1, pos2 = pos
            grid[pos1][pos2] = :X #considered spot
        end

        root1, root2 = @root_node.value
        grid[root1][root2] = :O #start

        grid.each { |row| p row }
    end


end

# p KnightPathFinder.valid_moves([3,2])

# p k.new_move_position(k.pos)

k = KnightPathFinder.new([3,2])

k.print_children
k.print_chessboard_with_considered_positions #:O is starting position