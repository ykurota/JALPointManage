class FlightclassesController < ApplicationController
  before_action :set_flightclass, only: [:show, :edit, :update, :destroy]

  # GET /flightclasses
  # GET /flightclasses.json
  def index
    @flightclasses = Flightclass.all
  end

  # GET /flightclasses/1
  # GET /flightclasses/1.json
  def show
  end

  # GET /flightclasses/new
  def new
    @flightclass = Flightclass.new
  end

  # GET /flightclasses/1/edit
  def edit
  end

  # POST /flightclasses
  # POST /flightclasses.json
  def create
    @flightclass = Flightclass.new(flightclass_params)

    respond_to do |format|
      if @flightclass.save
        format.html { redirect_to @flightclass, notice: 'Flightclass was successfully created.' }
        format.json { render :show, status: :created, location: @flightclass }
      else
        format.html { render :new }
        format.json { render json: @flightclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flightclasses/1
  # PATCH/PUT /flightclasses/1.json
  def update
    respond_to do |format|
      if @flightclass.update(flightclass_params)
        format.html { redirect_to @flightclass, notice: 'Flightclass was successfully updated.' }
        format.json { render :show, status: :ok, location: @flightclass }
      else
        format.html { render :edit }
        format.json { render json: @flightclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flightclasses/1
  # DELETE /flightclasses/1.json
  def destroy
    @flightclass.destroy
    respond_to do |format|
      format.html { redirect_to flightclasses_url, notice: 'Flightclass was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flightclass
      @flightclass = Flightclass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flightclass_params
      params.require(:flightclass).permit(:flightclass, :classcode, :addon)
    end
end
