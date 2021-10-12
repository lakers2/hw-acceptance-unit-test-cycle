#part 1
class AddColumn < ActiveRecord::Migration
  def change
    add_column :movies, :director, :string
  end
end
