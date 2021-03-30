class Book < ApplicationRecord

  # バリデーション
  validates :title, presence: true
  validates :body,  presence: true, length: { maximum: 200 }

  # userの関連付け
  belongs_to :user
end
