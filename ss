#!/usr/bin/env ruby
#
#   Easy tmux interface
#
#   In order:
#     * If we're given a session name parameter, use it.
#     * If multiple sessions exist, list them and explain how to attach to a specific one.
#     * If there's just one existing session, attach to it automatically.
#     * Start a new session.

require 'open3'

def show_sessions(sessions)
# Format and display info on available sessions as reported by tmux
  puts <<-END
  Multiple tmux sessions are available:

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
  return session[/\w+/]
end

def get_sessions
# Return an array of session description strings
  Open3.popen3('tmux list-sessions') do |stdin, stdout, stderr|
    return stderr.read[/failed to connect to server/] ? [] : stdout.read.split("\n")
  end
end

##[ BEGIN MAIN PROGRAM EXECUTION ]###########################################################

cmd = "tmux -2"

# If we're told what session to use, go ahead and do that
#
# ..also, check for a request just to list the session first
# FIXME:  This is kind of a cheap and crappy way to do it.  We just check for a
# param called "list" and simply skip the execution and fall through to the
# session listing code.  If the structure of this script changes, this will
# likely be missed and/or broken.

if ( ARGV.length > 0 and ARGV[0] != "list" ) then
    exec "#{cmd} attach -t #{ARGV[0]}"
end

# Otherwise, try to do the right thing automatically
sessions = get_sessions
if sessions.length > 1
  show_sessions(sessions)

elsif sessions.length == 1
  puts "Attaching to session '#{ name(sessions[0]) }'.."
  cmd += " attach"

else
  puts "No existing sessions.  Starting a new one.."

end

exec cmd
