require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :service_id => 123456798,
      :service_type => "facebook",
      :name => "John Connor",
      :link => "http://facebook.com/JohnConnor",
      :password => "password",
    }
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require a service_id" do
    no_service_id_user = User.new(@attr.merge(:service_id => ""))
    no_service_id_user.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end
  end

  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

end