# -*- coding: utf-8 -*-
# rspec spec/mongoid_auto_inc_spec.rb
require 'rspec'
require 'active_support'
require 'mongoid'
require 'mongoid_auto_inc'

describe MongoidAutoInc do
  before(:all) do
    Mongoid.master = Mongo::Connection.new.db("mongoid_auto_inc_test")
  end

  describe "auto increment" do
    before(:all) do
      class DocumentA
        include Mongoid::Document
        auto_increment :seq
      end
    end

    before(:each) do
      Mongoid.database["sequences"].remove
    end

    it "should be nil" do
      DocumentA.new.seq.should be_nil
    end

    it "should be 1" do
      DocumentA.create!.seq.should == 1
    end

    it "should be 2" do
      DocumentA.create!
      DocumentA.create!.seq.should == 2
    end
    
    it "should not auto increment when value is provided" do
      doc = DocumentA.create!(seq: 33)
      doc.seq.should == 33
    end
  end

  describe "auto increment with :collection option" do
    before(:all) do
      class DocumentB
        include Mongoid::Document
        auto_increment :seq, :collection => 'other_sequences'
      end
    end

    before(:each) do
      Mongoid.database["sequences"].remove
      Mongoid.database["other_sequences"].remove
    end

    it "should store sequence data to other_sequences collection" do
      DocumentB.create!.seq.should == 1
      DocumentB.create!.seq.should == 2
      Mongoid.database["sequences"].remove
      DocumentB.create!.seq.should == 3
      Mongoid.database["other_sequences"].remove
      DocumentB.create!.seq.should == 1
    end
  end

  describe "auto increment with :seed option" do
    before(:all) do
      class DocumentC
        include Mongoid::Document
        auto_increment :seq, :seed => 10
      end
      class DocumentD
        include Mongoid::Document
        auto_increment :seq
      end
    end

    before(:each) do
      Mongoid.database["sequences"].remove
    end

    it "should start with 11 (10 + 1)" do
      DocumentC.create!.seq.should == 11
      DocumentC.create!.seq.should == 12
      DocumentC.create!.seq.should == 13
      DocumentD.create!.seq.should == 1
      DocumentD.create!.seq.should == 2
    end
  end
end
