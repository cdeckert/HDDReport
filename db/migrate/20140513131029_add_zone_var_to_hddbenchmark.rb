class AddZoneVarToHddbenchmark < ActiveRecord::Migration
  def change
    add_column :hddbenchmarks, :zone_var, :double
  end
end
