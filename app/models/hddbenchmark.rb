class Hddbenchmark < ActiveRecord::Base
	has_many :measurements
	def iterations
		self.measurements.size()
	end
	def reduction_parameter
		(self.iterations/1000).round(0)
	end

	def reduced_measurements
		self.measurements.exclude_max_mins.reduce(self.reduction_parameter)
	end

	def mins
		self.measurements.exclude_max_mins.min(1000)	
	end
	def avg
		self.measurements.exclude_max_mins.avg(1000)	
	end
end
