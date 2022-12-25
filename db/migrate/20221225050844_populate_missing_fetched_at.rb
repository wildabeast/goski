class PopulateMissingFetchedAt < ActiveRecord::Migration[6.1]
  def change
    TicketPrice.find_each(batch_size: 200) { |tp| tp.update_attribute(:fetched_at, tp.created_at.beginning_of_hour); tp.save }
  end
end
