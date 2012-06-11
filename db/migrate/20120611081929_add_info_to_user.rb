class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :status, :string
    add_column :users, :about, :string
    add_column :users, :nik, :string
    add_column :users, :surname, :string

    add_index :users, :nik, unique: true
  end
end
