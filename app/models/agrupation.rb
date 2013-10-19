class Agrupation < ActiveRecord::Base
  belongs_to :member, class_name: "Musician"
  belongs_to :band
end
