module Kingpin

  # The Processing module augments classes with various processing features.
  module Processing

    # Run the given command.
    #
    # command - A string describing a command.
    # options - A hash describing options:
    #           :quietly - A boolean describing whether to silence STDOUT.
    #
    # Returns an array of the command's output and exit status, respectively.
    def run command, options = {}
      output = `#{command} 2>&1`

      wash! output

      [output, $?]
    end

    private

    # Strip ANSI Select Graph Rendition from the given string.
    def wash! string
      string.gsub! /\e\[[0-9]+m/, ""
    end

  end

end
