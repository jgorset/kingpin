module Kingpin
  module Frameworks

    class Framework
      include Logging
      include Processing

      def name
        "unnamed"
      end

      # Deploy the application.
      #
      # repository - A string describing the path to a repository.
      # branch     - A string describing a branch of the given repository.
      # block      - A block to be yielded in the context of the application.
      def deploy repository, branch
        destination = Kingpin.configuration.root + "/" + repository[/([^\/]*).git/, 1]

        section do
          log "Deploying #{name} application to #{destination}..."
        end

        section "Cloning repository..." do
          clone branch, repository, destination
        end

        Dir.chdir destination do
          yield
        end

        log "Deployment complete."
      end


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
