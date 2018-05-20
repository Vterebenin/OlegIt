class CreateDumpOlegs < ActiveRecord::Migration[5.2]
  def change
    create_table :dump_olegs do |t|
      t.string :answer

      t.timestamps
    end
  end
end
