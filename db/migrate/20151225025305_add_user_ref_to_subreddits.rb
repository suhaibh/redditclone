class AddUserRefToSubreddits < ActiveRecord::Migration
  def change
    add_reference :subreddits, :user, index: true
    add_foreign_key :subreddits, :users
  end
end
