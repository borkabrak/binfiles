class Deck
    @@ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
    @@suits = ["Spades", "Hearts", "Diamonds", "Clubs"]
    def initialize
        @deck = []
        @@suits.each { |suit|
            @@ranks.each { |rank|
                @deck.push(Card.new(rank,suit)) } }
    end

    def to_s
        @deck.join(", ") 
    end

    def inspect
        @deck.map { |c| c.to_abbr }.join(" ")
    end

    def shuffle!
         @deck.shuffle!
    end

    def length
        @deck.length
    end

    def draw
        @deck.pop
    end
end
