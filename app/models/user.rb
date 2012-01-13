class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :bio, :zipcode, :state, :city, :earnings, :hours_taught, :hours_learned, :image
  
  has_many :courses
  has_many :enrollments, :dependent => :destroy
  has_many :courses, :through => :enrollments, :source => "course_id", :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                     :class_name => "Relationship",
                                     :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  has_many :purchases
  has_many :authentications
  
  validates :firstname,  :presence => true, :length   => { :maximum => 50 }
  validates :lastname,   :presence => true, :length   => { :maximum => 50 }
  
  email_regex = /\A[\w+\-.]+@vanderbilt\.edu\z/i
  
  validates :email, :presence => true,
                    :format => {:with => email_regex, :message => "You must use a vanderbilt.edu email address"}, 
                    :uniqueness => true
  
  mount_uploader :image, AvatarUploader
  
  
  def enroll!(course, user)
    enrollments.create!(:course_id => course.id, :active => true)
    user.hours_learned = user.hours_learned + ((course.endtime - course.starttime)/3600).to_i
    course.user.earnings += course.cost
    user.save
    course.user.save
  end
  
  def enrolled?(course)
    enrollments.find_by_course_id(course)
  end
  
  def unenroll!(course)
    enrollments.find_by_course_id(course).destroy
    self.hours_learned = self.hours_learned - ((course.endtime - course.starttime)/3600).to_i
    course.user.earnings = course.user.earnings - course.cost
    self.save
    course.user.save
  end
  
  def teach!(course, user)
    user.hours_taught = user.hours_taught + ((course.endtime - course.starttime)/3600).to_i
    user.save
  end
  
  def unteach!(course, user)
    user.hours_taught = user.hours_taught - ((course.endtime - course.starttime)/3600).to_i
    user.save
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  def feed
    Course.from_users_followed_by(self)
  end
  
  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  #def password_required?
    #((authentications.empty? || !password.blank?) && super)
  #end
  
end
