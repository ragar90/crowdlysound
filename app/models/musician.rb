class Musician < ActiveRecord::Base
  has_many :songs, as: :author
  has_many :cowriters
  has_many :coauthored_songs, through: :cowriters
  has_many :music_tastes
  has_many :genres, through: :music_tastes
  has_many :instrument_skills
  has_many :instruments, through: :instrument_skills
  has_many :agrupations, foreign_key: "member_id"
  has_many :bands, through: :agrupations
  has_many :castings
  has_many :casting_songs, through: :castings

  attr_accessor :password
  
  before_save :encrypt_password

  #Alias for name, for using in json
  def value
    name
  end

  def create_band(band_params)
    band = Band.new(band_params)
    if !self.new_record? and band.save
      Agrupation.create(band_id: band.id, member_id: self.id, is_leader: true)
    else
      #Error Messages
    end
  end

  def self.find_musician(term)
    where("name LIKE '%#{term}%' OR email LIKE '%#{term}%'")
  end
  
  private
    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.password_digest = BCrypt::Engine.hash_secret(password, salt)
      end
    end

end
