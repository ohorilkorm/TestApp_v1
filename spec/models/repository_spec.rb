require 'rails_helper'

RSpec.describe Repository, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(id: 1, username: 'test')
    repo = user.repositories.create(user_id: user.id, name: 'test')
    expect(repo).to be_valid
  end

  it 'is not valid without user' do
    repo = Repository.create(user_id: nil, name: 'test')
    expect(repo).to_not be_valid
  end
end
