class AddLastSentAtToInterests < ActiveRecord::Migration[5.0]
  def change
    add_column :interests, :last_sent_at, :datetime
  end
end
