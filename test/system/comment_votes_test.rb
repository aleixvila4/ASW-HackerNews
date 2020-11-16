require "application_system_test_case"

class CommentVotesTest < ApplicationSystemTestCase
  setup do
    @comment_vote = comment_votes(:one)
  end

  test "visiting the index" do
    visit comment_votes_url
    assert_selector "h1", text: "Comment Votes"
  end

  test "creating a Comment vote" do
    visit comment_votes_url
    click_on "New Comment Vote"

    fill_in "Idcomment", with: @comment_vote.idComment
    fill_in "Idusuari", with: @comment_vote.idUsuari
    click_on "Create Comment vote"

    assert_text "Comment vote was successfully created"
    click_on "Back"
  end

  test "updating a Comment vote" do
    visit comment_votes_url
    click_on "Edit", match: :first

    fill_in "Idcomment", with: @comment_vote.idComment
    fill_in "Idusuari", with: @comment_vote.idUsuari
    click_on "Update Comment vote"

    assert_text "Comment vote was successfully updated"
    click_on "Back"
  end

  test "destroying a Comment vote" do
    visit comment_votes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Comment vote was successfully destroyed"
  end
end
