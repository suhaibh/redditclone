class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  before_save :downcase_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :links

  validates :name, presence: true, uniqueness: true

  private
  	def downcase_name
  		self.name.downcase!
  	end
end
