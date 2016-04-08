class TingUsage

    attr_accessor :minutes, :messages, :megabytes

def initialize(vals)
    (min, mes, meg) = vals
    @minutes = min
    @messages = mes
    @megabytes = meg
end

def to_s
    puts <<-END
    Minutes:   #{@minutes}
    Messages:  #{@megabytes}
    Megabytes: #{@megabytes}
    END
end

end
