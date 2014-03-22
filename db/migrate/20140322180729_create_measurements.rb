class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :hddbenchmark_id
      t.float :laptime
      t.integer :iteration

      t.timestamps
    end
  end
end
