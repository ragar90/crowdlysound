class Rock < ActiveRecord::Base
  belongs_to :musician
  belongs_to :content, polymorphic: true
end
