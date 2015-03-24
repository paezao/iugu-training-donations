class CreateDonationsTable < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :invoice_id
      t.integer :amount_cents
      t.datetime :donated_at
      t.timestamps
    end
  end
end
