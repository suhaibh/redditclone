class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  validates :body, presence: true, length: { maximum: 10000 }
  validates :user_id, presence: true
end
