class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :new

      t.timestamps null: false
    end
  end
end
