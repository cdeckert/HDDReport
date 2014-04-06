class Measurement < ActiveRecord::Base
	belongs_to :hddbenchmark

	scope :reduce, lambda{ |ratio| where("iteration % ? = ?", ratio, 0).select("iteration, laptime") }
	scope :reduce_from_to, lambda{ |from, to| where("iteration % ? = ? AND iteration >= ? AND iteration <= ?", ((to-from)/1000).round(0)+1, 0, from, to).select("iteration, laptime") }

	scope :from_to, lambda{ |from, to| where("iteration >= ? AND iteration <= ?", from, to).select("iteration, laptime, id") }
	scope :exclude_max_mins, lambda {joins(:hddbenchmark).where("laptime >= hddbenchmarks.min_measured_value AND laptime <= hddbenchmarks.max_measured_value")}

	scope :avg, lambda { |range| group(" cast(iteration / 1000 as int)").select("avg(laptime) as laptime, iteration") }
	scope :min, lambda { |range| group(" cast(iteration / 1000 as int)").select("min(laptime) as laptime, iteration") }

end
