#!/usr/bin/env ruby
#
# Run arbitrary SQL against the database, or choose from a list of common
# investigative tasks  (e.g. What modules show up in the portal for user
# <xxx>?)
#
# TIP: (in vim, type some sql, select it, and replace it with its result with:
#
#       :!sql<cr>

require 'pp'
require_relative "/home/jcarter/bin/binfiles/SQLCmd.rb"


# Saved bits of SQL
snippets = {

    'user-demo' => {

        :description => 'Get demographic information for a user',

        :args => 'usrID',

        :sql => 'select
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
        '
    },


    'hwlp' => {

        :description => 'Show info on the Healthworks Landing Pages',

        :args => nil,

        :sql =>'
            select 
                * 
            from CMSCustomTemplates T
                join CMSCustomTemplates_ChannelPartners X on T.cmscptID = X.cmscptID
        '

    },

    'customresources' => {

        :description => '...',

        :args => nil,

        :sql =>'
            select P.cmspid, P.cmspNavName, M.cmsmid from cmspages P
                join CMSPages_CMSModules M on P.cmspID = M.cmspID

                where P.cmspNavName like \'%resource%\'
        '

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
            puts "Subcommands"
            puts "==========="
            subcommands.each do |k,v|
                puts "#{k}: #{v["description"]}"
            end

            puts

            puts "Snippets"
            puts "========"
            snippets.each do |k,v|
                puts "#{k}: #{v[:description]}"
            end
        end
    }
    
}

#############################################################

# Read SQL from either arg list or piped input
#input = ARGV[0] || ARGF.read
command = nil
args = nil
if subcommands[ARGV[0]] then

    subcommands[ARGV[0]]["action"].call

    exit

elsif snippets[ARGV[0]] then
    command = snippets[ARGV[0]][:sql] 
    args = ARGV[1,] 
    exit

elsif ARGV.length < 1 then
    subcommands["help"]["action"].call
    exit

else
    command = ARGV[0]
end

sql = SQLCmd.new(command,args)
puts sql
