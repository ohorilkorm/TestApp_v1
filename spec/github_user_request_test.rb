# frozen_string_literal: true

require 'rails_helper'
require 'rspec/rails'
require 'net/http'

RSpec.describe 'Test github request users' do
  it 'is valid with valid with request message field return nil' do
    result = JSON.parse(Net::HTTP.get(URI.parse('https://api.github.com/users/test/repos')))
    expect(result[0].nil?).to eq false
  end
end
