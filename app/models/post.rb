# frozen_string_literal: true

class Post < ApplicationRecord
  validates :message, presence: true, length: { minimum: 1 }

  validates :user_id, presence: true

  def time_created
    created_at.strftime('%a, %d, %b, %Y, %H:%M:%S')
  end

  belongs_to :user
  has_many :comments, dependent: :destroy

end
