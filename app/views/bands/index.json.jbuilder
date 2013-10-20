json.array!(@bands) do |band|
  json.extract! band, :name, :description
  json.url band_url(band, format: :json)
end
