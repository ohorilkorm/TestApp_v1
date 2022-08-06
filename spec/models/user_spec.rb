require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(User.new(username: 'username')).to be_valid
  end
  it 'is not valid without username' do
    user = User.new(username: nil)
    expect(user).to_not be_valid
  end
  it 'is valid without id' do
    user = User.new(id: nil, username: 'username')
    expect(user).to be_valid
  end
end
