class AddJsonToDataset < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :rows_and_cols, :binary, limit: 10.kilobyte
  end
end
