class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string  :ip, null: false
      t.integer :times, null: false
      t.date    :date, null: false
      t.string  :referer, null: true

      t.timestamps null: false
    end
  end
end
