class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :bio, :zipcode, :state, :city, :earnings, :hours_taught, :hours_learned
  
  has_many :courses
  has_many :enrollments, :dependent => :destroy
  has_many :courses, :through => :enrollments, :source => "course_id", :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                     :class_name => "Relationship",
                                     :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  def enroll!(course, user)
    enrollments.create!(:course_id => course.id, :active => true)
    user.hours_learned = user.hours_learned + ((course.endtime - course.starttime)/3600).to_i
    user.save
  end
  
  def enrolled?(course)
    enrollments.find_by_course_id(course)
  end
  
  def unenroll!(course)
    enrollments.find_by_course_id(course).destroy
    self.hours_learned = self.hours_learned - ((course.endtime - course.starttime)/3600).to_i
    self.save
  end
  
  def teach!(course, user)
    user.hours_taught = user.hours_taught + ((course.endtime - course.starttime)/3600).to_i
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
  
  validates :firstname,  :presence => true, :length   => { :maximum => 50 }
  validates :lastname,   :presence => true, :length   => { :maximum => 50 }
  
end
