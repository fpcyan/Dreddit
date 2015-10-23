class Post < ActiveRecord::Base

  validates :title, :sub, :author, presence: true

  belongs_to(
    :sub,
    class_name: "Sub",
    foreign_key: :sub_id
  )

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )

end
