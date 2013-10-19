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

  #Alias for email, for using in json
  def value
    email
  end

  def create_band(band_params)
    band = Band.new(band_params)
    if !self.new_record? and band.save
      Agrupation.create(band_id: band.id, member_id: self.id, is_leader: true)
    else
      #Error Messages
    end
  end

  def self.find_musician(term, band_id = 0)
    if band_id == 0
      where("name LIKE '%#{term}%' OR email LIKE '%#{term}%'")
    else
      band = Band.find(band_id)

      where("(name LIKE '%#{term}%' OR email LIKE '%#{term}%') AND id NOT IN (?)", band.members.collect{ |m| m.id })
    end
  end

  def leader_of(band_id)
    !Agrupation.where(band_id: band_id, member_id: self.id, is_leader: true).empty?
  end
  
  private
    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.password_digest = BCrypt::Engine.hash_secret(password, salt)
      end
    end

end
