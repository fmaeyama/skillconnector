
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_privilege_groups
  has_many :privilege_groups, through: :user_privilege_groups
  belongs_to :person_info

  ## TODO add main image path in property, and return the image if exists
  def getUserImages

    imageHash = {}
    imageHash["main"]="icons/noImage.jpg"
    imageHash[:sub_image]="icons/sample-image.jpg"
    return imageHash

  end

end
