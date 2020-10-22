class UsuarisController < ApplicationController
  before_action :set_usuari, only: [:show, :edit, :update, :destroy]

  # GET /usuaris
  # GET /usuaris.json
  def index
    @usuaris = Usuari.all
  end

  # GET /usuaris/1
  # GET /usuaris/1.json
  def show
  end

  # GET /usuaris/new
  def new
    @usuari = Usuari.new
  end

  # GET /usuaris/1/edit
  def edit
  end

  # POST /usuaris
  # POST /usuaris.json
  def create
    @usuari = Usuari.new(usuari_params)

    respond_to do |format|
      if @usuari.save
        format.html { redirect_to @usuari, notice: 'Usuari was successfully created.' }
        format.json { render :show, status: :created, location: @usuari }
      else
        format.html { render :new }
        format.json { render json: @usuari.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuaris/1
  # PATCH/PUT /usuaris/1.json
  def update
    respond_to do |format|
      if @usuari.update(usuari_params)
        format.html { redirect_to @usuari, notice: 'Usuari was successfully updated.' }
        format.json { render :show, status: :ok, location: @usuari }
      else
        format.html { render :edit }
        format.json { render json: @usuari.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuaris/1
  # DELETE /usuaris/1.json
  def destroy
    @usuari.destroy
    respond_to do |format|
      format.html { redirect_to usuaris_url, notice: 'Usuari was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuari
      @usuari = Usuari.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usuari_params
      params.fetch(:usuari, {})
    end
end
