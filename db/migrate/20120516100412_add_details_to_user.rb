class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :born_on, :date

    add_column :users, :female, :boolean

  end
end
