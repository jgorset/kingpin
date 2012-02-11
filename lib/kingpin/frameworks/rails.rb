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
      def deploy repository_path, branch
        repository_name = repository_path[/([^\/]*).git/, 1]
        destination     = Kingpin.configuration.root + "/" + repository_name

        `git clone --branch=#{branch} #{repository_path} #{destination}`

        destination
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
