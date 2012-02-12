require "pathname"

module Kingpin
  module Frameworks

    class Rails < Framework

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

        if precompile_assets?
          precompile_assets

          gap
        end

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
      def precompile_assets?
        !File.exist? "public/assets/manifest.yml"
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
