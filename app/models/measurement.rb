class Measurement < ActiveRecord::Base
	belongs_to :hddbenchmark

	scope :reduce, lambda{ |ratio| where("iteration % ? = ?", ratio, 0).select("iteration, laptime, id") }
	scope :reduce_from_to, lambda{ |from, to| where("iteration % ? = ? AND iteration >= ? AND iteration <= ?", ((to-from)/1000).round(0)+1, 0, from, to).select("iteration, laptime, id") }

end