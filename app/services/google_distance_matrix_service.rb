class GoogleDistanceMatrixService
  require 'net/http'
  require 'json'

  TRANSLATION = {
    "Voiture" => "driving",
    "Transports en commun" => "transit",
    "Marche à pied" => "walking",
    # Options avec Transit
    "Le moins de marche à pied" => "less_walking",
    "Le moins de changements" => "fewer_transfers",
    # Choix du transport en commun
    "Bus" => "bus",
    "Train/Tramway/metro" => "rail"
  }.freeze




  def initialize(origin, destination, mode, routing_preference=nil, transit_mode=nil)
    @origin = origin
    @destination = destination
    @mode = TRANSLATION[mode] || mode
    @routing_preference = TRANSLATION[routing_preference] || routing_preference
    @transit_mode = TRANSLATION[JSON.parse(transit_mode).first]
    @api_key = ENV['GOOGLE_MAPS_API_KEY']
    puts "Parameters: #{@origin}, #{@destination}, #{@mode}, #{@routing_preference}, #{@transit_mode}"
  end

  def get_distance_and_duration
    base_uri = "https://maps.googleapis.com/maps/api/distancematrix/json"
    params = {
      units: 'metric',
      origins: @origin,
      destinations: @destination,
      mode: @mode,
      key: @api_key
    }
    params[:transit_routing_preference] = @routing_preference unless @routing_preference.nil?
    params[:transit_mode] = @transit_mode unless @transit_mode.nil?

    uri = URI(base_uri)
    uri.query = URI.encode_www_form(params)
    puts "URL de la requête : #{uri.to_s}"  # Ajoutez cette ligne pour afficher l'URL

    response = Net::HTTP.get(uri)
    json_response = JSON.parse(response)
    puts "API Response: #{json_response}"

    if json_response["rows"].first["elements"].first["status"] == "OK"
      distance = json_response["rows"].first["elements"].first["distance"]["text"]
      duration_text = json_response["rows"].first["elements"].first["duration"]["text"]
      duration_value = json_response["rows"].first["elements"].first["duration"]["value"]
      {
        distance: distance,
        duration_text: duration_text,
        duration_value: duration_value
      }
    else
      nil
    end
  end
end
