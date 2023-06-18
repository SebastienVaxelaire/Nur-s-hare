class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :family, dependent: :destroy

  after_create :create_associated_family

  private

  def create_associated_family
    family = Family.new(user_id: id)
    family.save
    # raise
  end

end
