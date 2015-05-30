#!/usr/bin/env ruby
# encoding: UTF-8
# Really just a toy class to play around with.
# Supposed to help with thinking about salary changes.
class Salary

    @@tax_percentage = 0.2

    # These are YEARLY
    @@insurance = 5550.00
    @@child_support = 3500.00

    attr_accessor :year

    def initialize(year)
        @year = year.to_i
    end

    # Net yearly income
    def net
        @year - (@year * @@tax_percentage) - @@insurance - @@child_support
    end

    def hour
        self.net / 2000.0
    end

    def month
        self.net / 12.0
    end

    def biweek
        self.net / 26
    end

    def week
        # Assuming 2 weeks unpaid vacation
        self.net / 50
    end

    def to_s
        "\n━━ $#{@year}/yr ($#{@year / 2000.0}/hr) ━━\n" +
        "Net:\n" + 
        "\t$%i/yr\n" % self.net +
        "\t$%.2f/hr\n" % self.hour +
        "\t$%.2f/mo\n" % self.month +
        "\t$%.2f/2wks\n" % self.biweek + 
        "\t$%.2f/wk\n" % self.week

    end

end

ARGV.each do |arg|
    puts Salary.new(arg.to_i * 1000)
end
