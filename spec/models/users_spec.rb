require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }

  it { should have_many(:starred_stories).through(:stars).class_name('Story') }
  it { should have_many(:stories) }
  it { should have_many(:nodes) }

  it { should_not allow_value("pas").for(:password) }
  it { should allow_value("password1").for(:password) }
  it { should_not allow_value("example.com").for(:email) }
  it { should allow_value("email@example.com").for(:email) }


  describe '#find_or_create_from_oauth' do

    it "should create new user with facebook info" do
      auth = OmniAuth.config.mock_auth[:facebook]
      @user = User.find_or_create_from_oauth(auth)
      expect(@user.name).to eq "John Facebook Doe"
    end

    it "should create a new user with twitter info" do
      auth = OmniAuth.config.mock_auth[:twitter]
      @user = User.find_or_create_from_oauth(auth)
      expect(@user.name).to eq "John Twitter Doe"
    end
  end

end
