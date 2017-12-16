class CreateFlightclasses < ActiveRecord::Migration[5.0]
  def change
    create_table :flightclasses do |t|
      t.string :flightclass
      t.string :classcode
      t.integer :addon

      t.timestamps
    end
  end
end
