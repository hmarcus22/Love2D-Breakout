local Entity = require "entities/entity"

local InputRow = Entity:extend()  

    function InputRow:new(maxSize)
        InputRow.super.new(self)
        self.maxSize = maxSize
        self.row = {}
        self.count = 0
        self.notFull = true
    end

    function InputRow:add(input)
        if self.count < self.maxSize then
            self.row[self.count +1] = input
            self.count = self.count + 1
            if self.count == self.maxSize then
                self.notFull = false
            else
                self.notFull = true
            end
            return true
        end
        return false
    end

    function InputRow:remove(index)
        if index >= 1 and index <= self.count then
            for i = index, self.count -1 do
                self.row[i] = self.row[i + 1]
            end
            self.count = self.count -1
            return true
        end
    end
    
    function InputRow:get(index)
        if index >= 1 and index <= self.count then
            return self.row[index]
        end
        return nil
    end
    
    function InputRow:size()
        return self.count
    end
    
    function InputRow:isEmpty()
        return self.count == 0
    end
    
    function InputRow:isFull()
        return self.count == self.maxSize
    end

    return InputRow