# Wrapper around the Windows-native 'sqlcmd' command, for executing SQL
# statements against a tSQL DB.
#
#   USAGE:
#
#       $ sqlcmd '-?'
#    
#       Microsoft (R) SQL Server Command Line Tool
#       Version 10.0.1600.22 NT INTEL X86
#       Copyright (c) Microsoft Corporation.  All rights reserved.
#       
#       usage: Sqlcmd            [-U login id]          [-P password]
#         [-S server]            [-H hostname]          [-E trusted connection]
#         [-d use database name] [-l login timeout]     [-t query timeout]
#         [-h headers]           [-s colseparator]      [-w screen width]
#         [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
#         [-c cmdend]            [-L[c] list servers[clean output]]
#         [-q "cmdline query"]   [-Q "cmdline query" and exit]
#         [-m errorlevel]        [-V severitylevel]     [-W remove trailing spaces]
#         [-u unicode output]    [-r[0|1] msgs to stderr]
#         [-i inputfile]         [-o outputfile]        [-z new password]
#         [-f <codepage> | i:<codepage>[,o:<codepage>]] [-Z new password and exit]
#         [-k[1|2] remove[replace] control characters]
#         [-y variable length type display width]
#         [-Y fixed length type display width]
#         [-p[1] print statistics[colon format]]
#         [-R use client regional setting]
#         [-b On error batch abort]
#         [-v var = "value"...]  [-A dedicated admin connection]
#         [-X[1] disable commands, startup script, enviroment variables [and exit]]
#         [-x disable variable substitution]
#         [-? show syntax summary]
#

class SQLCmd

    # Hmm..
    # require 'active_record'
    # ...
    # sql_statement = ActiveRecord::Base.send(:sanitize_sql, sql_statement, "CMSModuleContent")

    attr_accessor :command_text, :args, :result, :field_delimiter, :mode

    def initialize(command_text = nil, args = nil)

        @mode = "DEV"
        @args = args || ""
        @field_delimiter = "|"
        @command_text = command_text.sub('?', @args)

    end

    # Generate results dynamically
    def result 


        # Build server spec (prod or dev)
        server_spec = if (@mode == "PROD") then
            # Production DB needs specific credentials
            "-S ARTEMIS -U'dev_prod' -P'RheX03K!cK8' -d AHA_APP"
        else
            # Dev DB uses whatever credentials the command is run as
            "-S AH-DEV-DB01 -d AHA_APP"
        end

        valid? or raise "'#{@command_text}' is not a SELECT statement"

        command_output = `sqlcmd -u #{server_spec} -s'#{@field_delimiter}' -W -Q "#{@command_text}"`

        # Check for errors
        # This does NOT catch SQL ERRORS.  It catches failures of the 'sqlcmd'
        # utility.  Examine the result text of that command to detect errors from the DB.
        raise "Error running utility: $?" if (! $?.success?)

        command_output.split(/\r?\n/)

    end

    def to_str
        self.result.to_s
    end

    def to_s
        self.result.join "\n"
    end

    # Validate commands
    def valid?(command = @command_text)
        # Only allow SELECT statements, for now
        @command_text[/^\s*SELECT\s/i]
    end

end
