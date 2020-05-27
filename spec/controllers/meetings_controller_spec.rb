# frozen_string_literal: true

require 'spec_helper'
require 'capybara/dsl'
require 'rails_helper'
require 'faker'

RSpec.describe MeetingController, type: :controller do
  before do
    @user = Faker::Name.name
    @meeting = Meeting.create(meetingID: Faker::IDNumber.valid, internalMeetingID: Faker::IDNumber.valid, moderatorPW: Faker::IDNumber.valid, attendeePW: Faker::IDNumber.valid)
  end

  describe 'POST #create' do
    it 'creates a new meeting then user joins as moderator' do
      post :create, params: { name: @user }
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #home' do
    it 'shows home page' do
      get :home
      expect(response).to be_successful
    end
  end

  describe 'POST #delete' do
    it 'deletes a recording from the server' do
      post :delete, params: { id: [Faker::IDNumber.valid] }
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #join' do
    it 'joins a room from the server' do
      post :join, params: { name: @user, meetingID: @meeting.meetingID }
      expect(response).to have_http_status(302)
    end
  end
end
