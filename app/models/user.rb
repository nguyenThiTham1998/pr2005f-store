class User < ApplicationRecord
	has_many :orders
	has_many :comments, dependent: :destroy
	has_many :sub_comments, dependent: :destroy
	has_many :order_details, through: :orders
	has_one_attached :image
	scope :order_by_time,->{ order(created_at: :desc) }	
	scope :order_by_orders, -> { left_joins(:orders).group(:user_id).order('COUNT(orders.id) DESC')}
	has_one :cart
	scope :count_user, -> {where('created_at >=?', 24.hour.ago)}
	validates :VALID_PHONE_REGEX, length: { maximum: 12 },
				format: { with: /\A\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}\z/ }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable , omniauth_providers: [:facebook]

    def current_user?(user)
		user && user == self
	end     
    class << self     
	    def from_omniauth(auth)
	   		result = User.where(email: auth.info.email).first
		    if result
		      return result
		    else

		      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		        user.email = auth.info.email
		        user.password = Devise.friendly_token[0,20]
		        user.fullname = auth.info.name
		        user.image = auth.info.image
		        user.uid = auth.uid
		        user.provider = auth.provider


		        #  If you are using confirmable and the provider(s) you use validate emails
		        # user.skip_confirmation!
		      end
		    end
	  	end
	end  

end
