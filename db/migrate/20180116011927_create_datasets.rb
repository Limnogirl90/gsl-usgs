class CreateDatasets < ActiveRecord::Migration[5.1]
  def change
    create_table :datasets do |t|
      t.string :base_url
      t.string :site_number

      t.timestamps
    end
  end
end
