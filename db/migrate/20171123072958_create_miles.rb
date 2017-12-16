class CreateMiles < ActiveRecord::Migration[5.0]
  def change
    create_table :miles do |t|
      t.string :username
      t.date :flightdate
      t.string :departure
      t.string :destination
      t.string :flightclass
      t.integer :mileage
      t.integer :registeredmileage
      t.integer :fop
      t.integer :registeredfop
      t.string :registereduser
      t.string :updateuser

      t.timestamps
    end
  end
end
