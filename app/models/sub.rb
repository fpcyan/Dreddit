class Sub < ActiveRecord::Base

  validates :title, :moderator, presence: true

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id
  )

  has_many :posts, :through => :postsubs, source: :post
    class_name: "Post",
    foreign_key: :sub_id
  )

  has_many(
    :post_subs,
    inverse_of: :sub,
    class_name: "PostSub",
    foreign_key: :sub_id
  )

end
