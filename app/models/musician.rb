class Musician < ActiveRecord::Base
  has_many :songs, as: :author
  has_many :cowriters
  has_many :coauthored_songs, through: :cowriters
  has_many :music_tastes
  has_many :genres, through: :music_tastes
  has_many :instrument_skills
  has_many :instruments, through: :instrument_skills
  has_many :bands, foreign_key: :leader_id
  has_many :agrupations
  has_many :band_agrupations, through: :agrupations

  attr_accessor :password
  
  before_save :encrypt_password
  
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, salt)
    end
  end

end
