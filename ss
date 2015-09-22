#!/usr/bin/env ruby
#
#   Easy tmux interface
#
#     * If we're given a session name, attach to it.
#     * If multiple sessions exist, show them and explain how to attach to a one.
#     * If there's just one existing session, attach to it automatically.
#     * If there are no sessions, start a new one.
#
#     Subcommands:
#
#     * list - show available sessions and usage
#
#     TODO:
#
#     * new - start a new session, even if others exist

require 'open3'
require 'erb'
require_relative "/home/jcarter/bin/binfiles/ruby/commands"

def show_sessions(sessions)
# Format and display info on available sessions as reported by tmux
puts ERB.new(
"""
  <% if sessions.length > 0 then %>
  Available tmux sessions:

    #{ sessions.map {|s| sprintf("%-15s %40s", "[#{name(s)}]", s)}.join("\n  * ") }

  Attach to a session by label:

    $ <%= File.basename($PROGRAM_NAME) %> [label]
  <% else %>
  No existing sessions are available
  <% end %>

  Start a new session:

    $ tmux
""").result

end

def name(session)
# Get the name of a session from its info line
  return session[/[\w-]+/]
end

def get_sessions
# Return an array of session description strings
  Open3.popen3('tmux list-sessions') do |stdin, stdout, stderr|
    return stderr.read[/failed to connect to server/] ? [] : stdout.read.split("\n")
  end
end

##[ BEGIN MAIN PROGRAM EXECUTION ]###########################################################

sessions = get_sessions

# An array of arrays for easy(er) command configuration
commands = Commands.new [

    ["list", "display existing sessions", lambda { |args|
        session_list = args[0]
        show_sessions(session_list) 
    }],

    ["new", "start a new session", lambda { |args|
        puts "No existing sessions.  Starting a new one.."
        exec @@program_invocation
    }],

    ["attach", "Attach to a particular session", lambda {  |args|
        session_index = args[1]
        puts "Attaching to session '#{ name(sessions[session_index]) }'.."
        @@program_invocation += " attach"
    }],

    ["help", "Display possible commands", lambda { |args|
        puts ERB.new("""

            Available commands:
                <% for commands.each do |command| %>
                    <% command %>: <% command.description %>
                <% end %>

        """).result
        
    }]
]

if ( ARGV[0] ) then
# We have command-line arguments
    arg = ARGV.pop

    if ( commands[arg] ) then
    # We have predefined behavior for it.  Call it and give it the session list and the remaining args
        commands[arg].call [sessions, ARGV]

    else
    # We don't recognize the command - assume it's a session name to attach to.
        exec "#{tmux_cmd} attach -t #{arg}"

    end

else 
# No commands/arguments given

    if sessions.length < 1
    # We have no sessions, and no commands.  Just fire up tmux on a new session.
        commands["new"].call

    elsif sessions.length  == 1
    # We have exactly one session.  Attach to it.
        commands["attach"].call([sessions,0])

    else
    # Multiple sessions.  Show them to the user with instructions about how to attach to one
        commands["list"].call [sessions, ARGV]

    end

end
