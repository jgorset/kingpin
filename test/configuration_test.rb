require "kingpin"
require "minitest/spec"
require "minitest/autorun"
require "helpers"

describe Kingpin::Configuration do

  before do
    Kingpin.configure ROOT + "/fixtures/kingpin.yml"
  end

  it "can load its configuration" do
    Kingpin.configuration
  end

  it "can resolve where applications should be deployed" do
    Kingpin.configuration.root.must_equal "/tmp/kingpin"
  end

end
