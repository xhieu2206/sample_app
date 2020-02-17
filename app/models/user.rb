class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :microposts, dependent: :destroy

  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name,
            :presence => true,
            :length => { maximum: 50 }
  validates :email,
            presence: true, length: { maximum: 200 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string. Trả về hash digest của 1 string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Trả về 1 random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Ghi nhớ user trong DB để sử dụng trong session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Trả về true nếu như given token match với digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sử dụng tạm thời để  cho trang home page, sẽ thay đổi về sau
  def feed
    @microposts = Micropost.where("user_id = ?", self.id)
  end

  private

    def downcase_email
      self.email = email.downcase
    end
end
