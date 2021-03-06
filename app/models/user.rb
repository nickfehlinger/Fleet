class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://www.magicpay.net/wp-content/uploads/2016/08/Travel-Merchant-Account.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_friendship
  has_many :group_users
  has_many :groups, through: :group_users
  def fullname
  	"#{fname} #{lname}".strip
  end
end
