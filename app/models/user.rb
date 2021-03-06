class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
  #micropost validation
  has_many :microposts , dependent: :destroy
	#name validation
    ##these are the following user validations##
    has_many :microposts, dependent: :destroy
    has_many :relationships, foreign_key: "followed_id" , dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed

    has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy

    has_many :followers, through: :reverse_relationships, source: :follower

   ##end ##
  #session token 
  before_create :create_remember_token #namespace variable accessed using :

	validates :name, presence: true, length: {maximum: 50}
	#email validation
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					 format: { with: VALID_EMAIL_REGEX },
  						uniqueness: {case_sensitive: false}
  	#password validation
  	has_secure_password
  	validates :password, length: {minimum: 6} #accesing variable by : before variable 
  	#accessing the field by : after the variable

    def User.new_remember_token
      SecureRandom.urlsafe_base64 #it's not just Secure the method is SecureRandoom
    end

    def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def feed
      Micropost.where("user_id = ?", id)
    end
    
    def following?(other_user)
      relationships.find_by(followed_id: other_user.id)
    end

    def follow!(other_user)
      relationships.create!(followed_id: other_user.id)
    end

      def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy!
      end
      
    private

      def create_remember_token
        self.remember_token = User.encrypt(User.new_remember_token) #self saves the remember token
      end

end
