class Urls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :url
      t.string :status
      t.datetime :checked_at

      t.timestamps
    end
  end
end
