class Agrupation < ActiveRecord::Base
  belongs_to :member, class_name: "Musician"
  belongs_to :band_agrupation, class_name: "Band"
end
