module JClib
    def JClib.palindrome?(string)
        string == string.reverse
    end
end

class String
    def palindrome?
        self == self.reverse
    end
end
