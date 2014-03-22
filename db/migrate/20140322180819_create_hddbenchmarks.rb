class CreateHddbenchmarks < ActiveRecord::Migration
  def change
    create_table :hddbenchmarks do |t|
      t.string :name
      t.integer :device_id

      t.timestamps
    end
  end
end
