require 'digest'
require 'httparty'
require 'nokogiri'
class MeetingController < ApplicationController

    SERVER = "https://bbb.bill.blindside-dev.com/bigbluebutton/api"
    SECRET = "I1srupllZAut4ZpwrJwV5CDZ4nLwy7VsYE3EaBg"

    def home
    end

    def create
        id = Digest::MD5.hexdigest(Time.now.to_s)

        # Creating the meeting
        createcall = "createname=#{id}&meetingID=#{id}"+SECRET
        createsha1 = Digest::SHA1.hexdigest createcall
        createLink = SERVER+"/create?name=#{id}&meetingID=#{id}&checksum="+createsha1
        response = HTTParty.get(createLink)
        createInfo = Nokogiri::XML(response.body)
        attendeePW = createInfo.at_xpath("//attendeePW").text()

        # Join the meeting that was just created
        joincall = "joinfullName=#{params[:name]}&meetingID=#{id}&password=#{attendeePW}"+SECRET
        joinsha1 = Digest::SHA1.hexdigest joincall
        joinLink = SERVER+"/join?fullName=#{params[:name]}&meetingID=#{id}&password=#{attendeePW}&checksum="+joinsha1
        redirect_to joinLink
    end
end
