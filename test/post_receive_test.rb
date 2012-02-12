require "kingpin"
require "minitest/spec"
require "minitest/autorun"
require "helpers"

describe Kingpin::Hooks do

  before do
    Kingpin.configure ROOT + "/fixtures/kingpin.yml"

    `mkdir /tmp/kingpin`
  end

  after do
    `rm -rf /tmp/kingpin`
  end

  it "can deploy a rails application" do
    old_revision = "0000000000000000000000000000000000000000"
    new_revision = "377b81b513f3307c825c357556e97e16372ec9c8"
    ref          = "refs/heads/master"
    path         = "#{ROOT}/fixtures/repositories/rails.git"

    stdout, stderr = capture_io do
      Kingpin::Hooks.post_receive old_revision, new_revision, ref, path
    end

    assert_match stdout, /deployment complete/i
  end

  it "cannot deploy an ambigious application" do
    old_revision = "0000000000000000000000000000000000000000"
    new_revision = "0641d2df0b74e372e02c27e256c299afa469fe59"
    ref          = "refs/heads/master"
    path         = "#{ROOT}/fixtures/repositories/djangorails.git"

    assert_raises Kingpin::Frameworks::AmbigiousApplication do
      Kingpin::Hooks.post_receive old_revision, new_revision, ref, path
    end

  end

end
