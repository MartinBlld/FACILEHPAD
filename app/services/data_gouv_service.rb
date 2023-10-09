require 'net/http'
require 'json'

class DataGouvService
  BASE_URL = 'https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/healthref-france-finess/records'.freeze

  def self.fetch_data
    offset = 0
    limit = 100

    loop do
      url = URI("#{BASE_URL}?where=categetab%3A%20500&limit=#{limit}&offset=#{offset}")
      response = Net::HTTP.get_response(url)

      if response.is_a?(Net::HTTPSuccess)
        data = JSON.parse(response.body)
        Rails.logger.info "API Response: #{data.inspect}"

        break if data['results'].blank?  # Break the loop if no more results

        create_etablissements(data['results'])

        # Increment the offset for the next API call
        offset += limit
      else
        Rails.logger.error "Error: #{response.code} - #{response.message}"
        break  # If there is an error, stop the process
      end
    end
  end

  def self.create_etablissements(records)
    records.each_with_index do |record, index|
      # Vérification et Logging si 'record' est nil
      if record.nil?
        Rails.logger.error "Record #{index} is nil"
        next  # Passe au prochain record
      end
      finesset = record.dig('nofinesset')
      siret = record.dig('siret')
      raison_sociale = record.dig('rs')
      adresse = [
        record.dig('numvoie'),
        record.dig('typvoie'),
        record.dig('voie'),
        record.dig('ligneacheminement')
      ].compact.join(' ')
      telephone = record.dig('telephone')
      date_maj = record.dig('datemaj_structure')  # Ajustez la clé si nécessaire
      # Extraction des coordonnées (latitude et longitude) à partir de la clé 'coord'
      latitude = record.dig('coord', 'lat')
      longitude = record.dig('coord', 'lon')
      status = record.dig('libmft')

      # Vérifiez la présence des valeurs avant de les utiliser
      if siret.nil? || raison_sociale.nil? || adresse.nil?
        Rails.logger.error "Record #{index} is missing required fields: #{record.inspect}"
        next  # Skip to the next record
      end

      attributes = {
        finesset: finesset,
        siret: siret,
        raison_sociale: raison_sociale,
        adresse: adresse,
        telephone: telephone,
        date_maj: date_maj,
        latitude: latitude,
        longitude: longitude,
        status: status
      }

      etablissement = Etablissement.new(attributes)
      unless etablissement.save!(validate: false)
        Rails.logger.error "Failed to create Etablissement: #{etablissement.errors.full_messages.join(', ')}"
      end
    end
  end
end
