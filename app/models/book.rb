class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user#has_manyとセット　userとアソシエーション
  has_many :favorites, dependent: :destroy#いいね機能と関連付け
  has_many :book_comments, dependent: :destroy#コメント機能と関連付け

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)#引数で渡されたﾕｰｻﾞｰidがfavoritesﾃｰﾌﾞﾙに存在するかを
  end
end
