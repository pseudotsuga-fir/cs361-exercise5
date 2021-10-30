def run_all

end

def test_participants_filled_with_user_objects
    participant_emails = "fake1@example.com\nfake2@example.com\nfake3@example.com"
    participants = Participants.new(participant_emails)
    participants.generate_participants_from_email_string

    assert_equal(true, participants.all? {|participant| participant.type? == User}, "participants array does not contain only users.")
end

def test_workflow_run_does_not_return_nil
    discussion = Discussion.new(title: "fake", ...)
    host = User.find(42)
    participant_emails = "fake1@example.com\nfake2@example.com\nfake3@example.com"
    participants = Participants.new(participant_emails)
    participants.generate_participants_from_email_string

    workflow = LaunchDiscussionWorkflow.new(discussion, host, participants)
    assert_not_equal(nil, workflow.run, "workflow returned nil")
end