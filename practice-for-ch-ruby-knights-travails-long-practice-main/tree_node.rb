class PolyTreeNode

    attr_accessor :parent, :children, :value 

    def initialize(value)
        @value = value
        @parent = nil 
        @children = [] 
    end 

    def parent=(parent)
        if !@parent.nil?
            @parent.children.delete(self)
        end 

        @parent = parent  

        if !parent.nil? 
            parent.children << self if !parent.children.include?(self)
        end 
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise MethodError.new "Node is not self's child" if !self.children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target)
        return self if self.value == target 
        return nil if self.children.empty?
        @children.each do |child|
            result = child.dfs(target)
            return result if !result.nil? 
        end 
        nil 
    end

    def bfs(target)

        return self if self.value == target 
        
        queue = [*@children]

        until queue.empty?
            last = queue.shift
            return last if last.value == target
            queue.push(*last.children)
        end

        nil
    end
     #why are we calling children on the self node if we just want the root node in the queue 

     #wont it just be the root node

     #so it wont represent the nodes seperately
    
    
end