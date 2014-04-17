class HddbenchmarkController < ApplicationController
  before_action :set_hddbenchmark, only: [:show, :edit, :update, :destroy, :avg, :results, :min]
  skip_before_filter :verify_authenticity_token
  def upload
  	data = params[:data]
  	theBenchmark = Hddbenchmark.create(:name => params[:testName])

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
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hddbenchmark
      @benchmark = Hddbenchmark.find(params[:id])
    end
    def hddbenchmark_params
      params.require(:hddbenchmark).permit(:name, :max_measured_value, :min_measured_value)
    end
end
