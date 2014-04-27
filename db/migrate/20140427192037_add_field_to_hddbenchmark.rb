class AddFieldToHddbenchmark < ActiveRecord::Migration
  def change
    add_column :hddbenchmarks, :hd_geometry_heads, :integer
    add_column :hddbenchmarks, :hd_geometry_sectors, :integer
    add_column :hddbenchmarks, :hd_geometry_start, :integer
    add_column :hddbenchmarks, :hd_geometry_cylinders, :long
    add_column :hddbenchmarks, :HDIO_GET_UNMASKINTR, :long
    add_column :hddbenchmarks, :HDIO_GET_MULTCOUNT, :long
    add_column :hddbenchmarks, :HDIO_GET_KEEPSETTINGS, :long
    add_column :hddbenchmarks, :HDIO_GET_32BIT, :long
    add_column :hddbenchmarks, :HDIO_GET_NOWERR, :long
    add_column :hddbenchmarks, :HDIO_GET_DMA, :long
    add_column :hddbenchmarks, :HDIO_GET_NICE, :long
    add_column :hddbenchmarks, :HDIO_GET_WCACHE, :long
    add_column :hddbenchmarks, :HDIO_GET_ACOUSTIC, :long
    add_column :hddbenchmarks, :HDIO_GET_ADDRESS, :long
    add_column :hddbenchmarks, :HDIO_GET_BUSSTATE, :long
  end
end
