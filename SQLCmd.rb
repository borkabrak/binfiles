# Wrapper around the Windows-native 'sqlcmd' command, for executing SQL
# statements against a tSQL DB.
#
# ...  be careful.

class SQLCmd

    # Hmm..
    # require 'active_record'
    # ...
    # sql_statement = ActiveRecord::Base.send(:sanitize_sql, sql_statement, "CMSModuleContent")

    attr_accessor :command_text, :args, :result, :field_delimiter

    def initialize(command_text = nil, args = nil)
        if command_text.nil?  then
            raise "SQL command required to initialize."
        end

        @args = args || ""
        @field_delimiter = "|"
        @command_text = command_text.sub('?', @args)
        @result = self.execute

    end

    def execute

        # Validate commands.  Try not to do anything dangerous.
        # Putting this here is safer than checking at init, and letting it
        # change between then and now.
        if ! @command_text[/^\s*SELECT\s/i] then
            puts "Sorry, I'm only allowed to touch SELECT statements, at least for now."
            return nil
        end

        # Dev
        command_output = `sqlcmd -u -S AH-DEV-DB01 -d AHA_APP -s'#{@field_delimiter}' -W -Q "#{@command_text}"`

        # Prod
        #command_output = `sqlcmd -u -U'dev_prod' -P??? -S AH-DEV-DB01 -d AHA_APP -s'#{@field_delimiter}' -W -Q "#{@command_text}"`

        # This does NOT catch SQL ERRORS.  It catches failures of the 'sqlcmd'
        # utility.  Examine the result text of that command to detect errors.
        raise "Error running utility: $?" if (! $?.success?)

        @result = command_output.split(/\r?\n/)

        @result

    end

    def to_str
        self.to_s
    end

    def to_s
        @result.join "\n"
    end

end
