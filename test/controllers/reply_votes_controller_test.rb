require 'test_helper'

class ReplyVotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reply_vote = reply_votes(:one)
  end

  test "should get index" do
    get reply_votes_url
    assert_response :success
  end

  test "should get new" do
    get new_reply_vote_url
    assert_response :success
  end

  test "should create reply_vote" do
    assert_difference('ReplyVote.count') do
      post reply_votes_url, params: { reply_vote: { idReply: @reply_vote.idReply, idUsuari: @reply_vote.idUsuari } }
    end

    assert_redirected_to reply_vote_url(ReplyVote.last)
  end

  test "should show reply_vote" do
    get reply_vote_url(@reply_vote)
    assert_response :success
  end

  test "should get edit" do
    get edit_reply_vote_url(@reply_vote)
    assert_response :success
  end

  test "should update reply_vote" do
    patch reply_vote_url(@reply_vote), params: { reply_vote: { idReply: @reply_vote.idReply, idUsuari: @reply_vote.idUsuari } }
    assert_redirected_to reply_vote_url(@reply_vote)
  end

  test "should destroy reply_vote" do
    assert_difference('ReplyVote.count', -1) do
      delete reply_vote_url(@reply_vote)
    end

    assert_redirected_to reply_votes_url
  end
end
