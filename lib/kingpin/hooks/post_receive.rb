module Kingpin
  module Hooks

    # Git post-receive hook.
    class PostReceive

      def initialize old_revision, new_revision, reference, repository_path
        destination = "/tmp/checkout"
        branch      = reference.sub "refs/heads/", ""

        `git clone --branch=#{branch} #{repository_path} #{destination}`

        framework = Frameworks.identify destination

        framework.deploy repository_path, branch
      ensure
        `rm -rf #{destination}`
      end

    end

  end
end
