module Kingpin

  # The Logging module augments classes with various logging features.
  module Logging

    # Disable logging.
    def silence
      @silent = true
    end

    # Determine whether to log.
    def silent?
      !!@silent
    end

    # Log an empty line.
    def gap
      puts
    end

    # Log a message to STDOUT.
    #
    # message - A string describing the message to log.
    # options - A hash describing options:
    #           :indent - An integer describing how many spaces to indent by.
    #           :prefix - A string describing how the message should be prefixed.
    #
    # Returns nothing.
    def log message, options = {}
      options = {
        indent: 0,
        prefix: ""
      }.merge(options)

      message.lines.each do |line|
        STDOUT.puts " " * options[:indent] + options[:prefix] + line unless silent?
      end
    end

    # Log a message to STDERR.
    #
    # message - A string describing the message to log.
    # options - A hash describing options:
    #           :indent - An integer describing how many spaces to indent by.
    #           :prefix - A string describing how the message should be prefixed.
    #
    # Returns nothing.
    def error message, options = {}
      options = {
        indent: 0,
        prefix: ""
      }.merge(options)

      message.lines.each do |line|
        STDERR.puts " " * options[:indent] + options[:prefix] + line unless silent?
      end
    end

  end

end
