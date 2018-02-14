class AddUidAndSettingsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uid, :string
    add_column :users, :settings, :jsonb, null: false, default: {}
    add_index :users, :uid
    add_index :users, :settings, using: :gin
  end
end
