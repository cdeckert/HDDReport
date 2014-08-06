class HddbenchmarkController < ApplicationController
  before_action :set_hddbenchmark, only: [:show, :edit, :update, :destroy, :avg, :results, :min, :jumps]
  skip_before_filter :verify_authenticity_token
  def upload
  	data = params[:data]
  	theBenchmark = Hddbenchmark.create(
      :name => params[:testName],
      :hd_geometry_heads => params[:properties]["hd_geometry.heads"],
      :hd_geometry_sectors => params[:properties]["hd_geometry.sectors"],
      :hd_geometry_start => params[:properties]["hd_geometry.start"],
      :hd_geometry_cylinders => params[:properties]["hd_geometry.cylinders"],


      :HDIO_GET_UNMASKINTR => params[:properties]["HDIO_GET_UNMASKINTR"],
      :HDIO_GET_MULTCOUNT => params[:properties]["HDIO_GET_MULTCOUNT"],
      :HDIO_GET_KEEPSETTINGS => params[:properties]["HDIO_GET_KEEPSETTINGS"],
      :HDIO_GET_32BIT => params[:properties]["HDIO_GET_32BIT"],
      :HDIO_GET_NOWERR => params[:properties]["HDIO_GET_NOWERR"],
      :HDIO_GET_DMA => params[:properties]["HDIO_GET_DMA"],
      :HDIO_GET_NICE => params[:properties]["HDIO_GET_NICE"],
      :HDIO_GET_WCACHE => params[:properties]["HDIO_GET_WCACHE"],
      :HDIO_GET_ACOUSTIC => params[:properties]["HDIO_GET_ACOUSTIC"],
      :HDIO_GET_ADDRESS => params[:properties]["HDIO_GET_ADDRESS"],
      :HDIO_GET_BUSSTATE => params[:properties]["HDIO_GET_BUSSTATE"],
      :properties => params[:modePages].to_json
    )

  	measurements = []
  	data.each_with_index do |d, i|
  		measurements << Measurement.new(:laptime => d, :hddbenchmark_id => theBenchmark.id, :iteration => i)
  	  if measurements.size() > 1000
        Measurement.import measurements
        measurements = []
      end
    end
  	

	#puts data
    respond_to do |format|
  	  format.json{ render :json => "hello"}
	  end
  end

  def results
    @benchmark = Hddbenchmark.find(params[:id])
    if params[:from] == nil
      data = @benchmark.reduced_measurements
    else
      data = @benchmark.measurements.exclude_max_mins.reduce_from_to(params[:from].to_i, params[:to].to_i)
    end
    @result = []
    data.each do |d|
      @result << [d.iteration, d.laptime]
    end
    
    respond_to do |format|
      format.html
      format.json{ render :json => @result}
    end
  end

  def min
    data = @benchmark.mins
    
    @result = []
    data.each do |d|
      @result << [d.iteration, d.laptime]
    end

    respond_to do |format|
      format.html
      format.json{ render :json => @result}
    end
  end

  def avg
    data = @benchmark.avg
    
    @result = []
    data.each do |d|
      @result << [d.iteration, d.laptime]
    end

    respond_to do |format|
      format.html
      format.json{ render :json => @result}
    end
  end


  def jumps
    data = @benchmark.avg
    oldvalue = 0
    oldvalue2 = 0
    @result = []

    data.each do |d|
      oldvalue2 = oldvalue
      oldvalue = d.laptime
      if (oldvalue2 - d.laptime).abs > @benchmark.zone_var
        @result << [d.iteration, d.laptime]
      end
    end


    respond_to do |format|
      format.html
      format.json{ render :json => @result}
    end
  end


  # PATCH/PUT /hddbenchmarks/1
  # PATCH/PUT /hddbenchmarks/1.json
  def update
    respond_to do |format|
      puts hddbenchmark_params
      if @benchmark.update(hddbenchmark_params)
        format.html { redirect_to @benchmark, notice: 'Hddbenchmark was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @benchmark.errors, status: :unprocessable_entity }
      end
    end
  end

  

  def index
  	
  	@benchmarks = Hddbenchmark.all
  end

  def show
  	#@benchmark = Hddbenchmark.find(params[:id])
    begin
      @properties = JSON.parse(@benchmark.properties)
      @properties = @properties.enum_for(:each_slice, 20).to_a
    rescue
      @properties = nil
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hddbenchmark
      @benchmark = Hddbenchmark.find(params[:id])
    end
    def hddbenchmark_params
      params.require(:hddbenchmark).permit(:name, :max_measured_value, :min_measured_value, :device_id, :zone_var)
    end
end
