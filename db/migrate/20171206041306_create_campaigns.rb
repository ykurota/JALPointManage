class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :ctype
      t.string :ctypedetail
      t.string :bway
      t.float :bpoint

      t.timestamps
    end
  end
end
