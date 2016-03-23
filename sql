#!/usr/bin/env ruby
#
# Run (almost) arbitrary SQL against the database, or choose from a list of common
# investigative tasks called 'snippets' (e.g. What modules show up in the portal for user
# <xxx>?)
#
# TIP: (in vim, type some sql, select it, and replace it with its result with:
#
#       :!sql<cr>
#
# TODO:
#
#   Store snippets in a file (YAML?)

require 'json'

if `hostname`['NSU-DEV'] then
    require_relative "/home/jcarter/bin/binfiles/SQLCmd.rb"
else 
    require_relative "/home/jon/bin/SQLCmd.rb"
end


# Saved bits of SQL
snippets = {

    'test' => {
        :description => 'Test basic functionality',
        :args => nil,
        :sql => "SELECT TOP(10) hID from hraHeaders"
    },

    'tables' => {
        :description => 'List tables',
        :args => nil,
        :sql => "SELECT table_name FROM information_schema.tables WHERE TABLE_TYPE = 'BASE TABLE'"
    },

    'columns' => {

        :description => 'List columns',
        :sql => "
        SELECT T.table_name + '.' + C.column_name as 'TABLE.COLUMN'

            FROM INFORMATION_SCHEMA.TABLES T  
                JOIN INFORMATION_SCHEMA.COLUMNS C on T.table_name = C.table_name

            WHERE T.table_type = 'BASE TABLE'

            ORDER BY T.table_name
        "
    },

    'user-demo' => {

        :description => "Get demographic information for a user",

        :args => 'usrID',

        :sql => "select
            U.usrFN,
            U.usrLN,
            U.usrAddr,
            U.usrAddr2,
            U.usrCity,
            U.usrState,
            U.usrZip,
            U.usrDOB,
            U.usrGender,
            U.usrSSN,
            U.empID,
            U.usrBestPhone,
            U.usrEmail
        from hraUsers U
        where usrID = ?
        "
    },


    'hwlp' => {

        :description => "Show info on the Healthworks Landing Pages",

        :args => nil,

        :sql =>"
            select 
                * 
            from CMSCustomTemplates T
                join CMSCustomTemplates_ChannelPartners X on T.cmscptID = X.cmscptID
        "

    },

    'customresources' => {

        :description => 'show custom resources',

        :args => nil,

        :sql =>"
            select P.cmspid, P.cmspNavName, M.cmsmid from cmspages P
                join CMSPages_CMSModules M on P.cmspID = M.cmspID

                where P.cmspNavName like '%resource%'
        "

        },

    'user-custom-layout' => {

        :description => 'Info about a user in custom layouts, by username',
        :args => nil,
        :sql => "
            select 
                U.usrID,
                U.usrUsername,
                U.usrFN + U.usrLN as 'Name',
                CP.cpid 

            from ChannelPartners CP
                join Employers E on CP.cpID = E.cpID
                join hraUsers U on E.empID = U.empID

            where U.usrUsername = \'?\'
        "
    }
}

subcommands = {
    'help' => {

        'description' => 'Show usage info',

        'action' => lambda do
            puts "USAGE"
            puts "#{$0} ['prod'] <subcommand|snippet|sql statement>"
            puts
            puts "'prod' - use production database"
            puts
            puts "Subcommands"
            puts "==========="
            subcommands.keys.sort.each do |k|
                v = subcommands[k]
                puts "#{k}: #{v["description"]}"
            end

            puts

            puts "Snippets"
            puts "========"
            snippets.keys.sort.each do |k|
                v = snippets[k]
                puts "#{k}: #{v[:description]}"
            end
        end
    },

    'snippets' => {
        'description' => 'Show available snippets',

        'action' => lambda do 
            puts "Available Snippets"
            snippets.keys.sort.each do |k|
                v = snippets[k]
                puts "#{k}: #{v[:description]}"
            end
        end
        
    },

    'snippets_dump' => {

        'description' => "Dump snippets as JSON",
        
        'action' => lambda do
            puts snippets.to_json
        end
    }
    
}

#############################################################

# Read SQL from either arg list or piped input
#input = ARGV[0] || ARGF.read
command = nil
args = nil
mode = "DEV" 

# Determine whether we mean to run against production
if ARGV.delete ARGV.find {|e| e.downcase == "prod" } then
    mode = "PROD"
end

# Used a subcommand?
if subcommands[ARGV[0]] then

    subcommands[ARGV[0]]["action"].call

    exit

# Run a snippet?
elsif snippets[ARGV[0]] then
    command = snippets[ARGV[0]][:sql] 
    args = ARGV[1,] 

# Need help?
elsif ARGV.length < 1 then
    subcommands["help"]["action"].call
    exit

# Nope - run an explict command given as an argument
else
    command = ARGV[0]
end

# Finally, create and use the object 
sql = SQLCmd.new(command,args)
sql.mode = mode

puts sql
