class Band < ActiveRecord::Base
  
  has_many :songs, as: :owner
  belongs_to :leader, class_name: :musician
  has_many :agrupations
  has_many :members, through: :agrupations

  #Associations for follows
  has_many :follow_bands
  has_many :followers, :through => :follow_bands

  def add_member(musician_email)
  	musician = Musician.find_by_email(musician_email)

  	if !musician.nil? && members.where(:id => musician.id).empty?
  		Agrupation.create!(band_id: self.id, member_id: musician.id, is_leader: false)
  	end
  end

  def remove_member(musician_id)
  	agrupation = Agrupation.where(band_id: self.id, member_id: musician_id).first rescue nil
  	agrupation.destroy!
  end

  def includes_member?(musician_id)
  	!members.where(:id => musician_id).empty?
  end

end