class Card

    attr_accessor :rank, :suit

    # Handling non-standard cards is the responsibility of the consuming
    # class ("Blackjack", eg.), though it should probably do so by
    # extending this class once it's 'require'd
    # The order here determines the value of the card if rank ties, suit is used

    @@ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
    @@suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
        

    def initialize(rank, suit)
        @rank = rank
        @suit = suit
    end

    def to_s
        "[" + 
            (@rank.class == Fixnum ? @rank.to_s : @rank.to_s.chars.first) +
            "/" +
            @suit.to_s.chars.first.downcase +
        "]"
    end

    def inspect
        "<" + @rank.to_s + " of " + @suit.to_s + ">"
    end

    include Comparable
    def <=>(other)
        r1 = @@ranks.index(self.rank) 
        r2 = @@ranks.index(other.rank)
        s1 = @@suits.index(self.suit)
        s2 = @@suits.index(other.suit)
        return r1 == r2 ? s1 <=> s2 : r1 <=> r2
    end

end
