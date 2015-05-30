#!/usr/bin/env ruby
# 
#   Manage tmux sessions
#
#   In order:
#     * If we're given a session name parameter, use it
#     * If multiple sessions, list them and explain how to attach to a specific one
#     * If there's just one existing session, attach to it
#     * start a new session

require 'open3'

def show_sessions(sessions)
# Display info on a given array of session data
  puts <<-END
  Sessions:
#{sessions.map {|s| "[#{name s}]#{s}"}.join("\n")}

  Attach to one with
    tmux attach -t [name]
END
end

def name(session)
# Get the name of a session from its info line
  return session[/\w+/]
end

def get_sessions
# Return an array of session description strings
  Open3.popen3('tmux list-sessions') do |stdin, stdout, stderr|
    return stderr.read[/failed to connect to server/] ? [] : sessions = stdout.read.split("\n") 
  end
end

## BEGIN ##########################################################################################

cmd = "tmux -2"
# If we're told what session to use, go ahead and do that
exec "#{cmd} attach -t #{ARGV[0]}" if ARGV.length > 0

# Otherwise, try to do the right thing automatically
sessions = get_sessions
if sessions.length > 1
  show_sessions sessions
elsif sessions.length == 1
  puts "Attaching to session '#{name sessions[0]}'.."
  cmd += " attach"
else
  puts "No sessions.  Starting one.."
end

exec cmd
