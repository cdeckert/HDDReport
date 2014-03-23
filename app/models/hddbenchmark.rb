class Hddbenchmark < ActiveRecord::Base
	has_many :measurements
	def iterations
		self.measurements.size()
	end
	def reduction_parameter
		(self.iterations/1000).round(0)
	end
end
