class Musician < ActiveRecord::Base
  
  has_many :songs, as: :owner
  has_many :cowriters, :foreign_key => "coauthor_id"
  has_many :coauthored_songs, through: :cowriters
  has_many :music_tastes
  has_many :genres, through: :music_tastes
  has_many :instrument_skills
  has_many :instruments, through: :instrument_skills
  has_many :agrupations, foreign_key: "member_id"
  has_many :bands, through: :agrupations
  has_many :castings
  has_many :casting_songs, through: :castings
  has_many :music_sheets
  has_many :rocks
  
  #Associations for follows
  has_many :fu_followers, :class_name => 'FollowUser', :foreign_key => 'user2_id'
  has_many :fu_followings, :class_name => 'FollowUser', :foreign_key => 'user1_id'
  has_many :followers, :through => :fu_followers
  has_many :followings, :through => :fu_followings
  has_many :follow_bands
  has_many :following_bands, :through => :follow_bands

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

  def belongs_to_band?(band_id)
    !bands.where(:id => band_id).empty?
  end

  def is_guest_user
    is_guest
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

  ######################## FOLLOWS
  def follows_user(tmp_user)
    !followings.where(:id => tmp_user.id).empty?
  end

  def follow(tmp_user)
    FollowUser.create!(:user1_id => self.id, :user2_id => tmp_user.id)
  end

  def unfollow(tmp_user)
    FollowUser.find_by_user1_id_and_user2_id(self.id, tmp_user.id).destroy!
  end

  def currently_follows_band(tmp_band)
    !follow_bands.where(:band_id => tmp_band.id).empty?
  end

  def follow_band(tmp_band)
    FollowBand.create!(:musician_id => self.id, :band_id => tmp_band.id)
  end

  def unfollow_band(tmp_band)
    FollowBand.find_by_band_id_and_musician_id(tmp_band.id, self.id).destroy!
  end

  ######################## PERMISSIONS
  def can_edit_music_sheet?(music_sheet)
    cowriter = self.cowriters.where(coauthored_song_id: music_sheet.song.id).first
    return (can_edit_song?(music_sheet.song) and cowriter.instrument_id == music_sheet.instrument_id)
  end

  def can_edit_song?(song)
    if song.owner_id == self.id && song.owner_type == self.class.to_s
      true
    elsif self.coauthored_song_ids.include?(song.id)
      true
    else
      false
    end
  end

  #MAIN QUERIES
  def feed_loader(total = 12)
    elements = []
    cowriting_songs_activities(total).map{ |item| elements << build_feed_message(item, 1) }
    suggest_followings_songs(total).map{ |item| elements << build_feed_message(item, 2) }
    suggest_following_bands_songs(total).map{ |item| elements << build_feed_message(item, 3) }
    suggest_newest_songs(total).map{ |item| elements << build_feed_message(item, 4) }

    elements.sort! { |a, b|  b[:updated] <=> a[:updated] }
  end

  def cowriting_songs_activities(total = 12)
    participating_in_songs = music_sheets.collect{ |ms| ms.song_id }
    MusicSheet.where("song_id IN (?)", participating_in_songs).order("updated_at DESC").limit(total)
  end

  def suggest_followings_songs(total = 12)
    followings_ids = followings.collect{ |m| m.id }
    MusicSheet.joins(:song).where("songs.owner_type='Musician' AND songs.owner_id IN (?)", followings_ids).order("updated_at DESC").limit(total)
  end

  def suggest_following_bands_songs(total = 12)
    followings_ids = following_bands.collect{ |m| m.id }
    MusicSheet.joins(:song).where("songs.owner_type='Band' AND songs.owner_id IN (?)", followings_ids).order("updated_at DESC").limit(total)
  end

  def suggest_newest_songs(total = 12)
    genres_ids = genres.collect{ |g| g.id }
    instruments_ids = instruments.collect{ |i| i.id }
    Song.where("genre_tags.genre_id IN (?) OR instrument_tags.instrument_id IN (?)", genres_ids, instruments_ids).joins(:genre_tags, :instrument_tags).order("updated_at DESC").limit(total).group("songs.id")
  end

  def make_search(value)
  end
  
  private
    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.password_digest = BCrypt::Engine.hash_secret(password, salt)
      end
    end

    def build_feed_message(item, kind)
      case kind
      when 1
        additional_message = !item.musician_id.nil? ? " by #{item.musician.name}" : ""
        return {title: "New updates in '#{item.song.name}' where you are collaborating", path: "/song/#{item.song_id}", message: "The music sheet for #{item.instrument.name} has been updated #{additional_message}", updated: item.updated_at}
      when 2
        additional_message = !item.musician_id.nil? ? " by #{item.musician.name}" : ""
        return {title: "New updates in #{item.song.name} of #{item.song.owner.name}", path: "/song/#{item.song_id}", message: "The music sheet for #{item.instrument.name} has been updated #{additional_message}", updated: item.updated_at}
      when 3
        additional_message = !item.musician_id.nil? ? " by #{item.musician.name}" : ""
        return {title: "New updates in #{item.song.name} of #{item.song.owner.name}", path: "/song/#{item.song_id}", message: "The music sheet for #{item.instrument.name} has been updated #{additional_message}", updated: item.updated_at}
      when 4
        return {title: "A new song is born", path: "/songs/#{item.id}", message: "Check for #{item.name} of #{item.owner.name} and give your appreciations!", updated: item.updated_at}
      end
    end

end
