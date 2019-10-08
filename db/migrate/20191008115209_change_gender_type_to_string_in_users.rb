# frozen_string_literal: true

class ChangeGenderTypeToStringInUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :gender, :string
  end

  def down
    change_column :users, :gender, :boolean
  end
end
