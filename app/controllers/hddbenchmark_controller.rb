class HddbenchmarkController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def upload
  	data = params[:data]

  	theBenchmark = Hddbenchmark.create(:name => "abc")

  	measurements = []
  	data.each do |d|
  		measurements << Measurement.new(:laptime => d, :hddbenchmark_id => theBenchmark.id)
  	end
  	Measurement.import measurements

	puts data
    respond_to do |format|
  	  format.json{ render :json => "hello"}
	  end
  end

  def index
  	
  	@benchmarks = Hddbenchmark.all
  end

  def show
  	@benchmark = Hddbenchmark.find(params[:id])
  end
end
