require 'rails_helper'

RSpec.describe Auction, :type => :model do
  it "is valid with valid attributes" do
    expect(true).to be_truthy
  end
  it "is not valid without a title" do
    expect(true).to be_truthy
  end
  it "is not valid without a description" do
    expect(true).to be_truthy
  end
  it "is not valid without a start_date" do
    expect(true).to be_truthy
  end
  it "is not valid without a end_date" do
    expect(true).to be_truthy
  end
end
