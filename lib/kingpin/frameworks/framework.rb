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

      # Clone the repository.
      def clone branch, repository, destination
        command = "git clone --branch=#{branch} #{repository} #{destination}"

        log command, indent: 2, prefix: "$ "

        output, status = run command

        unless status.success?
          error out, indent: 2, prefix: "! "
        end
      end

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
