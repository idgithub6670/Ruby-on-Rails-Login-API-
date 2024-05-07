# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  auth_token             :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :text
#  last_name              :text
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_auth_token            (auth_token)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_auth_token

  def generate_auth_token
    self.auth_token = SecureRandom.uuid
  end

  def jwt(exp=15.days.from_now)
    JWT.encode({auth_token: self.auth_token, exp: exp.to_i},
    Rails.application.credentials.secret_key_base, "HS256")
  end

  def as_json_with_jwt
    json = {}
    json[:first_name] = self.first_name
    json[:last_name] = self.last_name
    json[:auth_jwt] = self.jwt
    json
  end

  def as_profile_json
    json = {}
    json[:email] = self.email
    json[:first_name] = self.first_name
    json[:last_name] = self.last_name
    json
  end
end
