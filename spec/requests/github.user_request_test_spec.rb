
require 'rails_helper'
require 'rspec/rails'
require 'net/http'

RSpec.describe 'Test github request user' do
  it 'is valid with result message field login not nil' do
    result = JSON.parse(Net::HTTP.get(URI.parse('https://api.github.com/users/test')))
    expect(result['login'].nil?).to eq false
  end
end
