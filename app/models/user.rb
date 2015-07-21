class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  before_save :downcase_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :links
  has_many :comments

  validates :name, presence: true, uniqueness: true

 # total link score for a given user
 def score
  	total = 0
  	links.each do |link|
  		total += link.link_score
  	end
  	total
 end

 def email_required?
    false
 end

 def email_changed?
    false
 end


  private
  	def downcase_name
  		self.name.downcase!
  	end
end
