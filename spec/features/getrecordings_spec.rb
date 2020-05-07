require 'spec_helper'
require 'capybara/dsl'
require 'digest'
require 'httparty'
require 'nokogiri'



feature "All recordings are shown" do
    scenario "verify all recordings displayed" do
        visit "/"
        
        getRecordingCall = "getRecordings"+SECRET
        getRecordingsha1 = Digest::SHA1.hexdigest getRecordingCall
        getRecordingLink = SERVER+"/getRecordings?checksum="+getRecordingsha1
        response = HTTParty.get(getRecordingLink)
        recordingsXML = Nokogiri::XML(response.body).xpath("//recording")

        for recording in recordingsXML
            expect(page).to have_text(recording.xpath("./name").text())
        end
    end
end