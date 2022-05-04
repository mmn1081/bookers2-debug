class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy#アソシエーション
  #has_manとbelongs_to :userはセット,userの中のbooks　dependent: :destroyはセット(userが消えた場合booksも消える)
  has_many :favorites, dependent: :destroy#いいね機能と関連付けする
  has_many :book_comments, dependent: :destroy#コメント機能(book_comments)と関連付け
  has_one_attached :profile_image


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum:50 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
