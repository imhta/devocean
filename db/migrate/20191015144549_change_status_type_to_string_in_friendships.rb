# frozen_string_literal: true

class ChangeStatusTypeToStringInFriendships < ActiveRecord::Migration[6.0]
  def up
    change_column :friendships, :status, :string
  end

  def down
    change_column :friendships, :status, :integer
  end
end
