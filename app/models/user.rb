class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
  #micropost validation
  has_many :microposts , dependent: :destroy
	#name validation

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
    
    private

      def create_remember_token
        self.remember_token = User.encrypt(User.new_remember_token) #self saves the remember token
      end

end
