require 'test_helper'

class CommentVotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment_vote = comment_votes(:one)
  end

  test "should get index" do
    get comment_votes_url
    assert_response :success
  end

  test "should get new" do
    get new_comment_vote_url
    assert_response :success
  end

  test "should create comment_vote" do
    assert_difference('CommentVote.count') do
      post comment_votes_url, params: { comment_vote: { idComment: @comment_vote.idComment, idUsuari: @comment_vote.idUsuari } }
    end

    assert_redirected_to comment_vote_url(CommentVote.last)
  end

  test "should show comment_vote" do
    get comment_vote_url(@comment_vote)
    assert_response :success
  end

  test "should get edit" do
    get edit_comment_vote_url(@comment_vote)
    assert_response :success
  end

  test "should update comment_vote" do
    patch comment_vote_url(@comment_vote), params: { comment_vote: { idComment: @comment_vote.idComment, idUsuari: @comment_vote.idUsuari } }
    assert_redirected_to comment_vote_url(@comment_vote)
  end

  test "should destroy comment_vote" do
    assert_difference('CommentVote.count', -1) do
      delete comment_vote_url(@comment_vote)
    end

    assert_redirected_to comment_votes_url
  end
end
