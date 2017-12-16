class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :citycode
      t.string :cityname
      t.string :area

      t.timestamps
    end
  end
end
