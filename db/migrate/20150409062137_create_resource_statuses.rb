class CreateResourceStatuses < ActiveRecord::Migration
  def change
    create_table :resource_statuses do |t|
      t.integer :resource_id
      t.string :kind
      t.string :value

      t.timestamps null: false
    end
  end
end
