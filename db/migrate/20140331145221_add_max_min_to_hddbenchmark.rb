class AddMaxMinToHddbenchmark < ActiveRecord::Migration
  def change
    add_column :hddbenchmarks, :max_measured_value, :float
    add_column :hddbenchmarks, :min_measured_value, :float
  end
end
