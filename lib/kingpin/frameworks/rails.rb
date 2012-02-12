require "pathname"

module Kingpin
  module Frameworks

    class Rails < Framework

      def name
        "Ruby on Rails"
      end

      # Deploy the application.
      #
      # repository - A string describing the path to a repository.
      # branch     - A string describing a branch of the given repository.
      def deploy repository, branch

        super do
          section "Installing dependencies with #{`bundle -v`.chomp}..." do
            install_dependencies
          end

          section "Precompiling assets..." do
            precompile_assets
          end if precompile_assets?
        end

      end

      private

      # Install dependencies.
      def install_dependencies
        command = "bundle install"

        log command, indent: 2, prefix: "$ "

        output, status = run command

        if status.success?
          log output, indent: 2, prefix: "> "
        else
          error output, indent: 2, prefix: "! "
        end
      end

      # Precompile assets.
      def precompile_assets
        command = "rake assets:precompile"

        log command, indent: 2, prefix: "$ "

        output, status = run command

        unless status.success?
          error output, indent: 2, prefix: "! "
        end
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
