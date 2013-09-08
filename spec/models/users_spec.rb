require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:nodes) }

  it { should_not allow_value("pas").for(:password) }
  it { should allow_value("password1").for(:password) }
  it { should_not allow_value("example.com").for(:email) }
  it { should allow_value("email@example.com").for(:email) }

end
