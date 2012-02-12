require "kingpin/frameworks/framework"

module Kingpin

  # The Frameworks module encapsulates logic for identifying
  # frameworks and deploying applications built with them.
  module Frameworks
    @frameworks = []

    # List frameworks.
    #
    # Returns a list of classes that inherit from Framework.
    def self.list
      @frameworks
    end

    # Register a framework.
    #
    # framework - A subclass of Framework.
    #
    # Returns nothing.
    def self.register framework
      @frameworks.push framework
    end

    # Load frameworks.
    def self.load
      require "kingpin/frameworks/rails"
      require "kingpin/frameworks/django"
    end

    # Identify the framework at a given path.
    #
    # path - A string describing the path to the root of a web application.
    #
    # Returns a Framework instance describing the framework.
    def self.identify path
      candidates = []

      Frameworks.list.each do |framework|
        candidates.push framework if framework.detect path
      end

      if candidates.empty?
        raise UnknownFramework, "Your application doesn't match any known frameworks"
      end

      if candidates.length > 1
        raise AmbigiousApplication, "Your application matches any of the following frameworks: #{candidates.join(", ")}"
      end

      candidates.first.new
    end

    load

    # Exception raised when an application passes as multiple frameworks.
    class AmbigiousApplication < Exception; end

    # Exception raised when an application doesn't match any known framework.
    class UnknownFramework < Exception; end

  end
end
