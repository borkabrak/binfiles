# Allow a program to easily define arguments to respond to
#
#   FIXME:  Finish documenting how to use this in its final form.  
#
#   At the moment, what I've got is using it a bit like this:
#
#  # An array of arrays for easy(er) command configuration
#  commands = [
#  
#      ["list", "display existing sessions", lambda { |args|
#          session_list = args[0]
#          show_sessions(session_list) 
#      }],
#  
#      ["new", "start a new session", lambda { |args|
#          puts "No existing sessions.  Starting a new one.."
#          exec tmux_cmd 
#      }],
#  
#      ["attach", "Attach to a particular session", lambda {  |args|
#          session_index = args[1]
#          puts "Attaching to session '#{ name(sessions[session_index]) }'.."
#          tmux_cmd += " attach"
#      }],
#  
#      ["help", "Display possible commands", lambda { |args|
#          puts ERB.new("""
#  
#              Available commands:
#                  <% for commands.each do |command| %>
#                      <% command %>: <% command.description %>
#                  <% end %>
#  
#          """).result
#          
#      }]
#  
#  ].map { |command| Command.new(command) }

class Command
    attr_accessor :name, :description, :action

    # Setting this class var to a tmux command is not portable to other types
    # of commands.  Maybe Command should be sub-classed by something that sets
    # this?
    @@program_invocation = "tmux -2"

    def initialize(name, description, action)
        @name = name
        @description = description
        @action = action
    end

    def invoke(args)
        self.call args
    end

    def to_s
        "[#{@name}]: #{@description}"
    end

    def show
        @to_s
    end

    def call(args)
        @action.call args
    end

end

# A class defining a set of Command objects
class Commands

    attr_accessor :commands

    def initialize(commands)

        @commands = commands.map do |command| 
        # Allow each element of the initial commands collection to be
        # either a Command object, or an array of the form: 
        #   [ String name, String description, Proc action ]
        #
        # in which case that array is used to build the Command object on the fly
            (command.class == Command) ? command : Command.new( command[0], command[1], command[2])
        end

    end

    def [](index)
        # Commands can be indexed either by natural Integer index, or by name
        #   I.E., these both work:
        #
        #       commands[0]         # Return first command defined
        #
        #       commands["list"]    # Return command with the name "list"
        #
        # NOTE: A conflict should occur if you name a command something like "0" or "1"
        
        @commands[index.to_i] or @commands.find {|command| command.name == index }

    end

    def list
        @commands.each { |command| command.show }
    end

    def to_s
        @list
    end

end
