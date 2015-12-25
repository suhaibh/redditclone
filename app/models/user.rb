class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :links
  has_many :comments, dependent: :destroy
  has_many :subreddits, dependent: :destroy

  validates :name, presence: true
  

 # total link score for a given user
 def email_required?
    false
 end

 def score
  	total = 0
  	links.each do |link|
  		total += link.link_score
  	end
  	total
 end

 def email_changed?
    false
 end

end
