class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Avatar attachment
  has_one_attached :avatar

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 30 }
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  # Callbacks
  before_validation :generate_username, on: :create, if: -> { username.blank? }
  before_validation :downcase_email

  # OmniAuth callback handler
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name || auth.info.name&.split&.first || 'User'
      user.last_name = auth.info.last_name || auth.info.name&.split&.last || 'Name'
      user.avatar_url = auth.info.image

      # Generate unique username from email
      base_username = auth.info.email.split('@').first.gsub(/[^a-zA-Z0-9_]/, '_')
      user.username = generate_unique_username(base_username)

      # Skip email confirmation if using confirmable
      # user.skip_confirmation!
    end
  end

  # Instance methods
  def full_name
    "#{first_name} #{last_name}".strip
  end

  def avatar_thumbnail(size: '100x100')
    if avatar.attached?
      avatar.variant(resize_to_limit: size.split('x').map(&:to_i))
    elsif avatar_url.present?
      avatar_url
    else
      # Default avatar placeholder
      "https://ui-avatars.com/api/?name=#{URI.encode_www_form_component(full_name)}&size=256&background=random"
    end
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def generate_username
    base = email.present? ? email.split('@').first : "user"
    self.username = self.class.generate_unique_username(base)
  end

  def self.generate_unique_username(base)
    base = base.gsub(/[^a-zA-Z0-9_]/, '_').slice(0, 20)
    username = base
    counter = 1

    while exists?(username: username)
      username = "#{base}#{counter}"
      counter += 1
    end

    username
  end
end
