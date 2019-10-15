class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
