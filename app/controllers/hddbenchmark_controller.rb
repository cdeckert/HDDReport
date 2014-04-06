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
    @benchmark = Hddbenchmark.find(params[:id])
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
    @benchmark = Hddbenchmark.find(params[:id])
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

  

  def index
  	
  	@benchmarks = Hddbenchmark.all
  end

  def show
  	@benchmark = Hddbenchmark.find(params[:id])
  end
end
