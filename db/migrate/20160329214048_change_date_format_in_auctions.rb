class ChangeDateFormatInAuctions < ActiveRecord::Migration
  def up
    change_column :auctions, :end_date, :datetime
  end

  def down
    change_column :auctions, :end_date, :date
  end
end
