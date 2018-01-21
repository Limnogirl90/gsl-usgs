class AddJsonToDataset < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :rows_and_cols, :json
  end
end
