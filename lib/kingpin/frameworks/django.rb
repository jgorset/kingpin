require "pathname"

module Kingpin
  module Frameworks

    class Django < Framework

      class << self

        # Determine whether the web application at the given path
        # is developed with Django.
        #
        # path - A string describing the path to the root of a web application.
        #
        # Returns true if the path contains a Django application, or false if
        # it does not.
        def detect(path)
          path = Pathname.new(path)

          # Define some traits of an application developed with Django.
          traits = [
            "manage.py"
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
