class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 画像の紐付け
  attachment :profile_image

  # 1人のuserに対して、複数の投稿
  has_many :books, dependent: :destroy

  # バリデーション
  validates :name, uniqueness: true,
                   length: { in: 2..20 }

  validates :introduction, length: { maximum: 50 }

end
