class AddUserIdToOlegs < ActiveRecord::Migration[5.2]
  def change
    add_column :olegs, :user_id, :integer
  end
end
