# Exercise 6

class DiscussionWorkflow

  def initialize(discussion, host, participants)
    @discussion = discussion
    @host = host
    @participants = participants
  end

  # Expects @participants array to be filled with User objects
  def run
    return unless valid?
    run_callbacks(:create) do
      ActiveRecord::Base.transaction do
        discussion.save!
        create_discussion_roles!
        @successful = true
      end
    end
  end

  # ...

end

class Participants

  def initialize(participants_email_string)
    @participants_email_string = participants_email_string
    @participants = []
  end

  def generate_participants_from_email_string
    return if @participants_email_string.blank?
    @participants_email_string.split.uniq.map do |email_address|
      User.create(email: email_address.downcase, password: Devise.friendly_token)
    end
  end

end


discussion = Discussion.new(title: "fake", ...)
host = User.find(42)
participant_emails = "fake1@example.com\nfake2@example.com\nfake3@example.com"
participants = Participants.new(participant_emails)
participants.generate_participants_from_email_string

workflow = LaunchDiscussionWorkflow.new(discussion, host, participants)
workflow.run