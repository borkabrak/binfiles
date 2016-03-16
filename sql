#!/usr/bin/env ruby
#
# Run arbitrary SQL against the database, or choose from a list of common
# investigative tasks  (e.g. What modules show up in the portal for user
# <xxx>?)
#
# TIP: (in vim, type some sql, select it, and replace it with its result with:
#
#       :!sql<cr>
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
    }

}

#############################################################

# Read SQL from either arg list or piped input
#input = ARGV[0] || ARGF.read
command = nil
args = nil
if snippets[ARGV[0]] then
    command = snippets[ARGV[0]][:sql] 
    args = ARGV[1,] 
else
    command = ARGV[0]
end

sql = SQLCmd.new(command,args)
puts sql
