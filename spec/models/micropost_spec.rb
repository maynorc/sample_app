require 'spec_helper'

describe Micropost do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do
 
    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "micropost associations" do
  
    before(:each) do
      @user = FactoryGirl.create(:user, :email => "whatever@example.com")
      @mp1 = FactoryGirl.create(:micropost, :user => @user, :created_at => 1.day.ago)
      @mp2 = FactoryGirl.create(:micropost, :user => @user, :created_at => 1.hour.ago)
    end
 
    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end

    it "should have the right microposts in the right order" do
      @user.microposts.should == [@mp2, @mp1]
    end

    it "should destroy associated microposts" do
      @user.destroy
      [@mp1, @mp2].each do |micropost|
	Micropost.find_by_id(micropost.id).should be_nil
      end
    end
  end

  describe "validations" do

    it "should require a user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.microposts.build(:content => " ").should_not be_valid
    end

    it "should reject long content" do
      @user.microposts.build(:content => "a"*141).should_not be_valid
    end
  end
end
