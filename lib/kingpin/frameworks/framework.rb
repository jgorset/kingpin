module Kingpin
  module Frameworks

    class Framework
      include Logging
      include Processing

      private

      # Register frameworks for classes that inherit from this class.
      #
      # framework - The Class that inherited this class.
      #
      # Returns nothing.
      def self.inherited framework
        Frameworks.register framework
      end

    end

  end
end
