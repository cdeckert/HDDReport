class CreateAddPropertiesToHddbenchmarks < ActiveRecord::Migration
  def change
     add_column :hddbenchmarks, :properties, :text
  end
end
