class FilterType < ActiveRecord::Base
  has_many :casting_settings
  def title_name
    self.name.titleize
  end
end
