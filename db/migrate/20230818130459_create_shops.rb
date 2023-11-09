class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :access
      t.string :parking
      t.string :open_time
      t.string :closed_days
      t.text :menu
      t.text :remarks
      t.text :prohibited_matters
      t.text :when_to_buy_tickets
      t.text :number_of_seats
      t.text :call_timing
      t.timestamps
    end
  end
end
