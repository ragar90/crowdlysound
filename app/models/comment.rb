class Comment < ActiveRecord::Base
  belongs_to :author, class_name: :musician
  belongs_to :comentable, polymorphic: true
end
