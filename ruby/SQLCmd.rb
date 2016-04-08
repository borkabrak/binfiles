# Wrapper around the Windows-native 'sqlcmd' command, for executing SQL
# statements against a tSQL DB.
class SQLCmd

    attr_accessor :rawOutput, :resultSet

    require 'open3'

    def initialize(sql_statement = nil, dummy)
        puts "#{ARGV.inspect}"
        exit
        self.dummy_execute(sql_statement) if not sql_statement.nil?
    end

    def execute(cmd)

        # Execute the SQL and just save the raw result
        # TODO:
        #   Consider a better seperator ('-s' flag)
        @rawOutput = `sqlcmd -u -S AH-DEV-DB01 -d AHA_APP -s"|" -W -Q '#{cmd}'`
        puts "Error: $?" if (! $?.success?)

        #@rawOutput = <<-ENDHERE
        #cmssID|cmstID|cmssName|cmssDescription|cmssLastUpdatedTS|cmssTS
        #------|------|--------|---------------|-----------------|------
        #0|1|AHA Awesome Site|My Site Is Better Than Yours!|2014-08-22 10:35:|2014-08-22 10:35
        #2|1|CHS Livewell||2014-11-19 07:21:|2014-11-19 07:21
        #3|1|Development|Development Site|2015-10-26 16:11:|2015-10-26 16:11

        #(3 rows affected)
        #ENDHERE
    end

    def dummy_execute(cmd)
        # Test function for when I don't have sqlcmd available

        # Execute the SQL and just save the raw result
        # TODO:
        #   Consider a better seperator ('-s' flag)
        #
        @rawOutput = <<-ENDHERE
        cmssID|cmstID|cmssName|cmssDescription|cmssLastUpdatedTS|cmssTS
        ------|------|--------|---------------|-----------------|------
        0|1|AHA Awesome Site|My Site Is Better Than Yours!|2014-08-22 10:35:|2014-08-22 10:35
        2|1|CHS Livewell||2014-11-19 07:21:|2014-11-19 07:21
        3|1|Development|Development Site|2015-10-26 16:11:|2015-10-26 16:11

        (3 rows affected)
        ENDHERE

    end

    def parseRawResult

        output = @rawOutput.split("\n")
        puts "OUTPUT:#{output.class}"

        output.map do |line|
            line.split("|")
        end

    end

    def to_s
        @rawOutput
    end

end
