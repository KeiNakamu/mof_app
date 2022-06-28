class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  # GET /properties or /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1 or /properties/1.json
  def show
    @nearest_stations = @property.nearest_stations
  end

  # GET /properties/new
  def new
    @property = Property.new

    2.times { @property.nearest_stations.build}
  end

  # GET /properties/1/edit
  def edit
    @property.nearest_stations.build
  end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)
    if params[:back]
      render :new
    else
      if @property.save
        redirect_to properties_path, notice: "登録しました"
      else
        render :new
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    if @property.update(property_params)
      redirect_to properties_path, notice: "物件を編集しました！"
    else
      render :edit
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:name, :price, :address, :age, :memo, nearest_stations_attributes: [:station, :route, :time, :property_id, :id])
    end
end
