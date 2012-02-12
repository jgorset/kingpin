require "kingpin"
require "minitest/spec"
require "minitest/autorun"
require "helpers"

describe Kingpin::Frameworks do

  before do
    Kingpin.configure ROOT + "/fixtures/kingpin.yml"
  end

  it "maintains a list of frameworks" do
    Kingpin::Frameworks.list.must_include Kingpin::Frameworks::Rails
    Kingpin::Frameworks.list.must_include Kingpin::Frameworks::Django
  end

  it "can identify a rails app" do
    Kingpin::Frameworks.identify(ROOT + "/fixtures/frameworks/rails").must_be_instance_of Kingpin::Frameworks::Rails
  end

  it "can identify a django project" do
    Kingpin::Frameworks.identify(ROOT + "/fixtures/frameworks/django").must_be_instance_of Kingpin::Frameworks::Django
  end

  it "complains about ambigious applications" do
    lambda do
      Kingpin::Frameworks.identify(ROOT + "/fixtures/frameworks/djangorails")
    end.must_raise Kingpin::Frameworks::AmbigiousApplication
  end

  it "complains about unknown frameworks" do
    lambda do
      Kingpin::Frameworks.identify(ROOT + "/fixtures/frameworks/bar")
    end.must_raise Kingpin::Frameworks::UnknownFramework
  end

end
