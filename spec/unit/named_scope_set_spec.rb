require File.expand_path("../../spec_helper", __FILE__)

describe "Friendly::NamedScopeSet" do
  before do
    @klass             = Class.new
    @named_scope_klass = stub
    @scope_set         = Friendly::NamedScopeSet.new(@klass, @named_scope_klass)
    @scope             = stub
    @named_scope       = stub(:scope => @scope)
    @params            = {:order! => :created_at.desc}
    @named_scope_klass.stubs(:new).with(@klass, @params).returns(@named_scope)
    @klass.stubs(:named_scope_set).returns(@scope_set)
    @scope_set.add(:recent, @params)
  end

  describe "adding a scope" do
    it "adds a named_scope by that name to the set" do
      @scope_set.get(:recent).should == @named_scope
    end

    it "adds a method to the klass that returns an instance of the scope" do
      @klass.recent.should == @scope
    end
  end

  describe "getting an instance of a scope" do

    it "delegates to the named_scope" do
      @scope_set.get_instance(:recent).should == @scope
    end
  end
end
