class VoteController < ApplicationController
  def new
    @vote = Vote.new
  end
  def create
     @vote.save
  end
end
