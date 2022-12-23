class CreateTicketPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_prices do |t|
      t.references :ticket, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
