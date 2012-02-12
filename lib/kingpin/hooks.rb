module Kingpin

  # The Hooks module encapsulates git hooks.
  module Hooks

    # The post-receive hook deploys the pushed branch.
    #
    # old_revision    - A string describing the commit the repository advanced from.
    # new_revision    - A string describing the commit the repository advanced to.
    # reference       - A string describing the reference that was updated.
    # repository_path - A string describing the path to the repository that was pushed to.
    def self.post_receive old_revision, new_revision, reference, repository_path
      destination = "/tmp/kingpin/checkout"
      branch      = reference[/refs\/heads\/(.*)/, 1]

      `git clone --branch=#{branch} #{repository_path} #{destination}`

      framework = Frameworks.identify destination

      framework.deploy repository_path, branch
    ensure
      `rm -rf #{destination}`
    end
  end

end
