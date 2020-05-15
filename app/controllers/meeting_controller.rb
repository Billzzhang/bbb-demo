require 'digest'
require 'httparty'
require 'nokogiri'
class MeetingController < ApplicationController
    def home
        getRecordingCall = "getRecordings"+ENV['SECRET']
        getRecordingsha1 = Digest::SHA1.hexdigest getRecordingCall
        getRecordingLink = ENV['SERVER']+"/getRecordings?checksum="+getRecordingsha1
        response = HTTParty.get(getRecordingLink)
        recordingsXML = Nokogiri::XML(response.body).xpath("//recording")
        @recordings = []
        for recording in recordingsXML do
            rec_id = recording.xpath("./recordID").text()
            rec_url = recording.xpath("./playback/format/url").text()
            rec_name = recording.xpath("./name").text()
            newRec = Recording.new(rec_id, rec_url, rec_name)
            @recordings << newRec
        end
        @recordings.compact!

        @meetings = Meeting.all

    end

    def create
        id = Digest::MD5.hexdigest(Time.now.to_s)

        # Creating the meeting
        createcall = "createname=#{id}&meetingID=#{id}&record=true"+ENV['SECRET']
        createsha1 = Digest::SHA1.hexdigest createcall
        createLink = ENV['SERVER']+"/create?name=#{id}&meetingID=#{id}&record=true&checksum="+createsha1
        response = HTTParty.get(createLink)
        createInfo = Nokogiri::XML(response.body)
        moderatorPW = createInfo.at_xpath("//moderatorPW").text()
        attendeePW = createInfo.at_xpath("//attendeePW").text()
        meetingID = createInfo.at_xpath("//meetingID").text()
        internalMeetingID = createInfo.at_xpath("//internalMeetingID").text()

        newMeeting = Meeting.create(:meetingID => meetingID, :internalMeetingID => internalMeetingID, :moderatorPW => moderatorPW, :attendeePW => attendeePW)

        # Join the meeting that was just created
        joincall = "joinfullName=#{params[:name]}&meetingID=#{id}&password=#{moderatorPW}"+ENV['SECRET']
        joinsha1 = Digest::SHA1.hexdigest joincall
        joinLink = ENV['SERVER']+"/join?fullName=#{params[:name]}&meetingID=#{id}&password=#{moderatorPW}&checksum="+joinsha1
        redirect_to joinLink
    end

    def delete
        deleteIDs = params[:id].join(",")
        deletecall = "deleteRecordingsrecordID=#{deleteIDs}"+ENV['SECRET']
        deletesha1 = Digest::SHA1.hexdigest deletecall
        deleteLink = ENV['SERVER']+"/deleteRecordings?recordID=#{deleteIDs}&checksum="+deletesha1
        response = HTTParty.get(deleteLink)
        redirect_to "/"
    end

    def join
        # Join the meeting
        if (params.has_key?(:meetingID))
            puts params[:meetingID]
            meeting = Meeting.find_by(:meetingID => params[:meetingID])
            joincall = "joinfullName=#{params[:name]}&meetingID=#{meeting.meetingID}&password=#{meeting.attendeePW}"+ENV['SECRET']
            joinsha1 = Digest::SHA1.hexdigest joincall
            joinLink = ENV['SERVER']+"/join?fullName=#{params[:name]}&meetingID=#{meeting.meetingID}&password=#{meeting.attendeePW}&checksum="+joinsha1
            redirect_to joinLink
        else
            # render file: "#{Rails.root}/public/404.html", layout: false
        end
    end
end
