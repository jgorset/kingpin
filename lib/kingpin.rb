require "kingpin/version"

module Kingpin
  CONFIGURATION_PATH = "/etc/kingpin.yml"

  autoload :Frameworks,    "kingpin/frameworks"
  autoload :Hooks,         "kingpin/hooks"
  autoload :Configuration, "kingpin/configuration"
  autoload :Logging,       "kingpin/logging"
  autoload :Processing,    "kingpin/processing"

  # Configure Kingpin with the given configuration file.
  #
  # path - A string describing a path to the configuration file.
  def self.configure path
    @configuration = Configuration.new path
  end

  # Yield Kingpin's configuration.
  def self.configuration
    @configuration ||= Configuration.new CONFIGURATION_PATH
  end
end
