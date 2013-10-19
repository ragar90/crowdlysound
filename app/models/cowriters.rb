class Cowriters < ActiveRecord::Base
  belongs_to :musician
  belongs_to :song
end
