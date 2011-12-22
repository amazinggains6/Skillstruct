class Course < ActiveRecord::Base
  belongs_to :user
  has_many :enrollments, :dependent => :destroy
  has_many :users, :through => :enrollments, :source => "user_id", :dependent => :destroy
  
  default_scope :order => 'courses.created_at DESC'
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  validates :name, :presence => true
  validates :description, :presence => true
  
  private
  
    def self.followed_by(user)
          following_ids = %(SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id)
          where("user_id IN (#{following_ids}) OR user_id = :user_id",
                { :user_id => user })
    end
end
