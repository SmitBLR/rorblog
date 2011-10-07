require 'spec_helper'

describe Admin do

  before(:each) do
    @attr = {
      :email => "admin@example.com",
      :password => "password",
      :password_confirmation => "password"
    }
  end

  it "should create a new instance given a valid attribute" do
    Admin.create!(@attr)
  end

  it "should require an email address" do
    no_email_admin = Admin.new(@attr.merge(:email => ""))
    no_email_admin.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[admin@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_admin = Admin.new(@attr.merge(:email => address))
      valid_email_admin.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[admin@foo,com admin_at_foo.org example.admin@foo.]
    addresses.each do |address|
      invalid_email_admin = Admin.new(@attr.merge(:email => address))
      invalid_email_admin.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    Admin.create!(@attr)
    admin_with_duplicate_email = Admin.new(@attr)
    admin_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Admin.create!(@attr.merge(:email => upcased_email))
    admin_with_duplicate_email = Admin.new(@attr)
    admin_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @admin = Admin.new(@attr)
    end

    it "should have a password attribute" do
      @admin.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @admin.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      Admin.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      Admin.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Admin.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @admin = Admin.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @admin.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @admin.encrypted_password.should_not be_blank
    end

  end
end
