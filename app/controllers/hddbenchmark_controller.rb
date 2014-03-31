class HddbenchmarkController < ApplicationController
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
      data = @benchmark.measurements.exclude_max_mins.reduce(@benchmark.reduction_parameter)
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

  def max_results
    @benchmark = Hddbenchmark.find(params[:id])

    data = @benchmark.measurements.max(params[:id]) 
    @result = []
    data.each do |d|
      @result << [d.iteration, d.laptime]
    end
    
    respond_to do |format|
      format.html
      format.json{ render :json => @result}
    end
    
  end

  def index
  	
  	@benchmarks = Hddbenchmark.all
  end

  def show
  	@benchmark = Hddbenchmark.find(params[:id])
  end
end
