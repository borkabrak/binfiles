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
#
#   - More robust error handling
#       * Missing args
#       * Malformed or missing YAML
#
#   - Run time options:
#       * bare - output only SQL results (not header/footer stuff)
#       * verbose - output sql command, info on snippet/subcmd

require 'json'
require 'yaml'

##  CONFIGURATION OPTIONS  ##############################################################
#
# Read bits of precomposed SQL from a YAML file
snippets_file = "/home/jcarter/.config/sql/snippets.yaml"
#
#########################################################################################

if `hostname`['NSU-DEV'] then
    require_relative "/home/jcarter/bin/binfiles/SQLCmd.rb"
else 
    require_relative "/home/jon/bin/SQLCmd.rb"
end

snippets = YAML.load(File.read(snippets_file))
subcommands = {
    'help' => {

        'description' => 'Show usage info',

        'action' => lambda do
            puts "USAGE"
            puts
            puts "\t#{$0} ['prod'] <subcommand|snippet|sql statement>"
            puts
            puts "\t'prod' - use production database"
            puts
            puts
            puts "Subcommands"
            puts "==========="
            puts
            subcommands.keys.sort.each do |k|
                v = subcommands[k]
                puts "\t#{k} - #{v["description"]}"
                puts
            end

            puts
            puts

            puts "Snippets"
            puts "========"
            puts
            snippets.keys.sort.each do |k|
                v = snippets[k]
                puts "\t#{k}#{ " <#{v[:args]}>" if v[:args]} - #{v[:description]}"
                puts
            end
            puts
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

# Use a subcommand?
if subcommands[ARGV[0]] then
    subcommands[ARGV[0]]["action"].call
    exit

# Run a snippet?
elsif snippets[ARGV[0]] then
    command = snippets[ARGV[0]][:sql] 
    args = ARGV[1,] 

# No arguments - show usage and available subcommands/snippets
elsif ARGV.length < 1 then
    subcommands["help"]["action"].call
    exit

# No special case - run an explict command given as an argument
else
    command = ARGV[0]
end

# Finally, create and use the object 
sql = SQLCmd.new(command,args)
sql.mode = mode

puts sql
