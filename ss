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
#     * list - show available sessions and usage (TIP: 'ss l' shows tmux's own sessions)

require 'open3'

def show_sessions(sessions)
# Format and display info on available sessions as reported by tmux
  puts <<-END
  Available tmux sessions:

  * #{sessions.map {|s| sprintf("%-15s %40s", "[#{name(s)}]", s)}.join("\n  * ")}

  Attach to one:
    $ #{File.basename($PROGRAM_NAME)} [label]

  Start a new session:
    $ tmux

  END
  exit
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

cmd = "tmux -2"
sessions = get_sessions

# Respond to any commands we're specifically watching for in this script.
# NOTE: 'ss l' will show tmux's own session list.
if ( ARGV[0] and ARGV[0] == "list" ) then
    show_sessions(sessions)
end

# Assume any arg is a session name to attach to.
if ( ARGV.length > 0 ) then
    exec "#{cmd} attach -t #{ARGV[0]}"
end

# No session given - if we have multiple sessions, we can't proceed.  Show the
# user what they can choose.
if sessions.length > 1
  show_sessions(sessions)

# If exactly one session exists, attach to it.
elsif sessions.length == 1
  puts "Attaching to session '#{ name(sessions[0]) }'.."
  cmd += " attach"

# No sessions, no commands.  Just fire up tmux on a new session.
else
  puts "No existing sessions.  Starting a new one.."

end

exec cmd
