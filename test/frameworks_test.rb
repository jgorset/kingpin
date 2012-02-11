require "kingpin"
require "minitest/spec"
require "minitest/autorun"

describe Kingpin::Frameworks do

  it "maintains a list of frameworks" do
    Kingpin::Frameworks.list.must_include Kingpin::Frameworks::Rails
    Kingpin::Frameworks.list.must_include Kingpin::Frameworks::Django
  end

  it "can identify a rails app" do
    Kingpin::Frameworks.identify(File.dirname(__FILE__) + "/fixtures/frameworks/rails").must_be_instance_of Kingpin::Frameworks::Rails
  end

  it "can identify a django project" do
    Kingpin::Frameworks.identify(File.dirname(__FILE__) + "/fixtures/frameworks/django").must_be_instance_of Kingpin::Frameworks::Django
  end

  it "complains about ambigious applications" do
    lambda do
      Kingpin::Frameworks.identify(File.dirname(__FILE__) + "/fixtures/frameworks/djangorails")
    end.must_raise Kingpin::Frameworks::AmbigiousApplication
  end

  it "complains about unknown frameworks" do
    lambda do
      Kingpin::Frameworks.identify(File.dirname(__FILE__) + "/fixtures/frameworks/bar")
    end.must_raise Kingpin::Frameworks::UnknownFramework
  end

end
