class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy#アソシエーション
  #has_manとbelongs_to :userはセット,userの中のbooks　dependent: :destroyはセット(userが消えた場合booksも消える)

  has_many :favorites, dependent: :destroy#いいね機能と関連付けする
  has_many :book_comments, dependent: :destroy#コメント機能(book_comments)と関連付け

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy#フォローした関係づけ
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy#フォローされた関係
  # has_many :xxx, class_name: "モデル名", foreign_key: "(参照するカラム)○○_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed#そのユーザーがフォローしている人の一覧を出したい
  has_many :followers, through: :reverse_of_relationships, source: :follower#そのユーザーがフォローされている人の一覧を出したい
  #throughでｽﾙｰするﾃｰﾌﾞﾙ、sourceで参照するｶﾗﾑを指定
  has_one_attached :profile_image


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum:50 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(user_id)#ﾌｫﾛｰしたときの処理
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)#ﾌｫﾛｰを外すときの処理
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)#フォローしているか判定
    followings.include?(user)
  end

  def self.looks(search, word)
    if search == "perfect_match"#完全一致
       User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"#前方一致
       User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"#後方一致
      User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"#部分一致
      User.where("name LIKE?","%#{word}%")
    else
      User.all
    end
  end
end
