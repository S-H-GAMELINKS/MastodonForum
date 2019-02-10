class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def profile_url
    "#{self.email.gsub!(/^.+@/, "")}/@#{self.uid.gsub!(/@.+/, "")}"
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    if user != nil then
      user.update!(name: auth.extra.raw_info.display_name)
    end
      
    unless user
      user = User.create(
        name:     auth.extra.raw_info.display_name,
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
      user.save!
    end
    current_user = user
  end
      
  private
      
    def self.dummy_email(auth)
      "#{auth.uid}"
    end
end
