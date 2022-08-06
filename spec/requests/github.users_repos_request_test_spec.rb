require 'rails_helper'
require 'rspec/rails'
require 'net/http'

RSpec.describe 'Test github request users' do
  it 'is valid with message field return nil' do
    userResult = JSON.parse(Net::HTTP.get(URI.parse('https://api.github.com/users/test')))
    expect(userResult['message'].nil?).to eq true
  end
end
