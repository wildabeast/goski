class AddIndexToTickets < ActiveRecord::Migration[6.1]
  def change
    add_index :tickets, [:start_datetime, :end_datetime]
  end
end
