class Post < ApplicationRecord
  validates :content, presence: true, length: {in: 3..140}
end
