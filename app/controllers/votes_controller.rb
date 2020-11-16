class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(:idContrib => params[:idContrib], :idUsuari => params[:idUsuari])
    @contribution = Contribution.find(@vote.idContrib)
    @contribution.points += 1
    @contribution.save
    if @vote.save
     redirect_to request.referrer   
    else
      format.html { render :new }
      format.json { render json: @vote.errors, status: :unprocessable_entity }
    end
    
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @contribution = Contribution.find(@vote.idContrib)
    @vote.destroy
    @contribution.points -= 1
    @contribution.save
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:idContrib, :idUsuari)
    end
end

