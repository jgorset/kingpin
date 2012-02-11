require "kingpin"
require "minitest/spec"
require "minitest/autorun"

describe Kingpin::Hooks do

  it "can deploy a rails application" do
    skip
    
    old_revision = "0000000000000000000000000000000000000000"
    new_revision = "377b81b513f3307c825c357556e97e16372ec9c8"
    ref          = "refs/heads/foo"
    path         = "#{File.dirname(__FILE__)}/fixtures/repositories/rails.git"

    Kingpin::Hooks::PostReceive.new old_revision, new_revision, ref, path
  end

end
