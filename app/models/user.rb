class User < ActiveRecord::Base
  has_many :clients, :dependent => :destroy
  accepts_nested_attributes_for :clients
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token, :role, :clients_attributes
  # attr_accessible :title, :body
  
  before_save :ensure_authentication_token

  ROLES = %w[admin general guest]
end
