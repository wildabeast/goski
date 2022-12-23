class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
