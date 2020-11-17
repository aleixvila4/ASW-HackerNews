require "application_system_test_case"

class ReplyVotesTest < ApplicationSystemTestCase
  setup do
    @reply_vote = reply_votes(:one)
  end

  test "visiting the index" do
    visit reply_votes_url
    assert_selector "h1", text: "Reply Votes"
  end

  test "creating a Reply vote" do
    visit reply_votes_url
    click_on "New Reply Vote"

    fill_in "Idreply", with: @reply_vote.idReply
    fill_in "Idusuari", with: @reply_vote.idUsuari
    click_on "Create Reply vote"

    assert_text "Reply vote was successfully created"
    click_on "Back"
  end

  test "updating a Reply vote" do
    visit reply_votes_url
    click_on "Edit", match: :first

    fill_in "Idreply", with: @reply_vote.idReply
    fill_in "Idusuari", with: @reply_vote.idUsuari
    click_on "Update Reply vote"

    assert_text "Reply vote was successfully updated"
    click_on "Back"
  end

  test "destroying a Reply vote" do
    visit reply_votes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reply vote was successfully destroyed"
  end
end
