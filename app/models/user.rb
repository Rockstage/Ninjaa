class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :title, :body

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :profile_name,
  				  :birthday, :role, :gender, :contact_email, :contact_phone

  validates :email, presence: true, uniqueness: true
  validates :profile_name, presence: true,
  			uniqueness: true, 
              format: {
              with: /\A[a-zA-Z0-9_-]+\z/,
              message: "Must be formatted correctly using: a-z, A-Z, 0-9, - and _ "
            }
  validates :birthday, presence: true

  has_many :jobs


  # allows you to call if @user.sensei / or if current_user.ninjaa
  scope :sensei, where(:role => true)
  scope :ninjaa, where(:role => false)



end
