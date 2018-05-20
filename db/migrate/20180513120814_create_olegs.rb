class CreateOlegs < ActiveRecord::Migration[5.2]
  def change
    create_table :olegs do |t|
      t.string :filmTitle
      t.string :answer

      t.timestamps
    end
  end
end
