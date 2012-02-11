require "pathname"

module Kingpin
  module Frameworks

    class Rails < Framework
      include Logging

      # Deploy the application.
      #
      # repository - A string describing the path to a repository.
      # branch     - A string describing a branch of the given repository.
      #
      # Returns the path to the application.
      def deploy repository, branch
        destination = Kingpin.configuration.root + "/" + repository[/([^\/]*).git/, 1]

        # Clone the repository...
        log "Deploying Ruby on Rails application to #{destination}..."

        gap

        clone branch, repository, destination

        Dir.chdir destination

        gap

        install_dependencies

        gap

        precompile_assets if precompile?

        gap

        log "Deployment complete."

        destination
      end

      private

      # Clone the repository.
      def clone branch, repository, destination
        command = "git clone --branch=#{branch} #{repository} #{destination}"

        log "Cloning repository..."

        run command, true
      end

      # Install dependencies.
      def install_dependencies
        command = "bundle install"

        log "Installing dependencies with #{`bundle -v`.chomp}..."

        run command
      end

      # Precompile assets.
      def precompile_assets
        command = "rake assets:precompile"

        log "Precompiling assets..."

        run command, true
      end

      # Determine whether to precompile assets.
      def precompile?
        !File.exist? "public/assets/manifest.yml"
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

      class << self

        # Determine whether the web application at the given path
        # is developed with Ruby on Rails.
        #
        # path - A string describing the path to the root of a web application.
        #
        # Returns true if the path contains a Rails application, or false if
        # it does not.
        def detect(path)
          path = Pathname.new(path)

          # Define some traits of an application developed with Ruby on Rails.
          traits = [
            "script/rails",
          ]

          traits.each do |trait|
            return false unless path.join(trait).exist?
          end

          true
        end

      end

    end

  end
end
