class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id,presence: true # accessed using prior : and setting the attribute using after :
	validates :content, presence: true , length: { maximum: 140}

end
