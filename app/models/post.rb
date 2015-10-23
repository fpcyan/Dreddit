class Post < ActiveRecord::Base

  validates :title, :subs, :author, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )

  has_many(
    :post_subs,
    inverse_of: :post,
    dependent: :destroy,
    class_name: "PostSub",
    foreign_key: :post_id
  )

  has_many :subs, :through => :post_subs, source: :sub

end
