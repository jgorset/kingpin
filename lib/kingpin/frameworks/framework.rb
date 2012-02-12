module Kingpin
  module Frameworks

    class Framework
      include Logging

      private

      # Register frameworks for classes that inherit from this class.
      #
      # framework - The Class that inherited this class.
      #
      # Returns nothing.
      def self.inherited framework
        Frameworks.register framework
      end

      # Run the given command.
      #
      # command - A string describing a command.
      # quetly  - A boolean describing whether to silence STDOUT.
      def run command, quietly = false
        log command, indent: 2, prefix: "$ "

        out = `#{command} 2>&1`

        # Strip ANSI Select Graphic Rendition.
        out.gsub! /\e\[[0-9]+m/, ""

        if $?.success?
          log out, indent: 2, prefix: "> " unless quietly
        else
          error out, indent: 2, prefix: "! "

          gap

          abort "Deployment failed."
        end
      end

    end

  end
end
