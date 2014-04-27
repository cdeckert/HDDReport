json.array!(@devices) do |device|
  json.extract! device, :id, :name, :computer, :address
  json.url device_url(device, format: :json)
end
