class AddOrderIdToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :order_id, :string
  end
end
