class EtablissementProposition < ApplicationRecord
  belongs_to :etablissement
  belongs_to :proposition


  before_create :set_travel_time


  private

  def set_travel_time
    origin = "#{proposition.prospect_form.latitude_de_recherche},#{proposition.prospect_form.longitude_de_recherche}"
    destination = "#{etablissement.latitude},#{etablissement.longitude}"
    mode = "#{proposition.prospect_form.moyen_de_transport}"
    routing_preference = "#{proposition.prospect_form.routing_preference}"
    transit_option = "#{proposition.prospect_form.transit_option}"
    service = GoogleDistanceMatrixService.new(origin, destination, mode, routing_preference, transit_option)
    result = service.get_distance_and_duration

    if result
      self.moyen_de_transport = self.proposition.prospect_form.moyen_de_transport
      if self.moyen_de_transport == "Transports en commun"
      end
      puts "result[:mode] = #{result[:mode]}"
      self.routing_preference = result[:routing_preference]
      self.transit_option = result[:transit_option]
      self.temps_de_trajet_affichable = result[:duration_text]
      self.temps_de_transport_en_secondes = result[:duration_value]
    else
      return
      # Gérer le cas où l'API ne renvoie pas de résultat valide
      # Par exemple, loguer l'erreur ou lever une exception
    end
  end
end
