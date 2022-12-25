class AddFetchedAtToTicketPrice < ActiveRecord::Migration[6.1]
  def change
    add_column :ticket_prices, :fetched_at, :datetime
    TicketPrice.find_each(batch_size: 200) { |tp| tp.update_attribute(:fetched_at, tp.created_at.beginning_of_hour); tp.save }
  end
end
