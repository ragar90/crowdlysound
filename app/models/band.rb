class Band < ActiveRecord::Base
  has_many :songs, as: :author
  belongs_to :leader, class_name: :musician
  has_many :agrupations
  has_many :members, through: :agrupations
end
