require "yaml"

module Kingpin

  # The Configuration class encapsulates Kingpin's configuration.
  class Configuration

    # Load the given configuration file.
    #
    # path - A string describing the path to Kingpin's configuration file.
    def initialize path
      @yaml = YAML.load_file path
    end

    # Returns a string describing the directory Kingpin should deploy
    # applications to.
    def root
      @yaml["root"]
    end

  end

end
