json.array!(@musicians) do |musician|
  json.extract! musician, :id, :value
end