class User < ActiveRecord::Base
  has_many :bids, dependent: :destroy
  has_many :auctions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence:true
  validates :last_name, presence:true


  def full_name
    "#{first_name} #{last_name}".titleize.strip
  end

end
