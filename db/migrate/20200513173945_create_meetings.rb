class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :meetingID
      t.string :internalMeetingID
      t.string :moderatorPW
      t.string :attendeePW

      t.timestamps
    end
  end
end
