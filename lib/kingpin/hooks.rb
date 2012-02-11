module Kingpin

  # The Hooks module encapsulates the git hooks that work Kingpin's magic.
  module Hooks
    autoload :PostReceive, "kingpin/hooks/post_receive"
  end

end
