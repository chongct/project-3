class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :space
  has_many :reviews
  has_many :bookmarks

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'

  has_many :personal_messages, dependent: :destroy

  validates :first_name, :last_name, :username, presence: true

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

end
