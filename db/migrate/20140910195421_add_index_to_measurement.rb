class AddIndexToMeasurement < ActiveRecord::Migration
  def change
  	add_index :measurements, [:hddbenchmark_id]
  end
end
