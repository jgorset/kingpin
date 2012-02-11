require "kingpin"
require "minitest/spec"
require "minitest/autorun"
require "helpers"

describe Kingpin::Hooks do

  it "can deploy a rails application" do

    old_revision = "0000000000000000000000000000000000000000"
    new_revision = "377b81b513f3307c825c357556e97e16372ec9c8"
    ref          = "refs/heads/foo"
    path         = "#{ROOT}/fixtures/repositories/rails.git"

    begin
      application = Kingpin::Hooks.post_receive old_revision, new_revision, ref, path
      Dir.exist?(application).must_equal true
    ensure
      `rm -rf #{application}`
    end
  end

end
