require "kingpin"
require "minitest/spec"
require "minitest/autorun"
require "helpers"

describe Kingpin::Hooks do

  before do
    `mkdir /tmp/kingpin`
  end

  after do
    `rm -rf /tmp/kingpin`
  end

  it "can deploy a rails application" do
    old_revision = "0000000000000000000000000000000000000000"
    new_revision = "377b81b513f3307c825c357556e97e16372ec9c8"
    ref          = "refs/heads/foo"
    path         = "#{ROOT}/fixtures/repositories/rails.git"

    stdout, stderr = capture do
      application = Kingpin::Hooks.post_receive old_revision, new_revision, ref, path
    end

    stdout.must_match /deployment complete/i
  end

end
