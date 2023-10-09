require 'csv'
require 'open-uri'
require 'bigdecimal'

class PriceServicesEhpad
  CSV_URL = 'https://www.data.gouv.fr/fr/datasets/r/2567a6dc-f47c-4c84-9442-36275e9b1484'.freeze

  def self.fetch_and_update_data
    begin
      # Fetch the CSV data from the URL
      csv_data = URI.open(CSV_URL).read.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')

      # Specify the quote characters to handle special characters
      quote_chars = %w(" | ~ ^ & *)

      # Initialize the csv variable outside of the loop
      csv = nil

      # Try parsing the CSV using different quote characters
      quote_chars.each do |quote_char|
        begin
          csv = CSV.parse(csv_data, headers: true, col_sep: ';', quote_char: quote_char, header_converters: lambda { |h| h&.strip })
          # If parsing succeeds, exit the loop
          break if csv.present?
        rescue CSV::MalformedCSVError
          # If parsing fails, try with the next quote character
          next
        end
      end

      # Check if CSV data is present after parsing
      if csv.present?
        # Update the establishments with the parsed CSV
        update_etablissements(csv)
      else
        Rails.logger.error "CSV data is empty or could not be parsed."
      end
    rescue OpenURI::HTTPError => e
      Rails.logger.error "Error fetching CSV: #{e.message}"
    rescue => e
      Rails.logger.error "General error: #{e.message}"
    end
  end

  def self.update_etablissements(csv)
    puts "Updating establishments with data: #{csv.inspect}"  # Log the data

    csv.each do |row|
      # Your update logic here using row['header_name'] to access the data
      finesset = row['finessEt']
      etablissement = Etablissement.find_by(finesset: finesset)

      if etablissement.present?
        etablissement.update_columns(
          prix_hp_cs: convert_to_float(row['prixHebPermCs']),
          prix_hp_cd: convert_to_float(row['prixHebPermCd']),
          prix_hp_cs_ash: convert_to_float(row['prixHebPermCsa']),
          prix_hp_cd_ash: convert_to_float(row['prixHebPermCda']),
          prix_ht_cs: convert_to_float(row['prixHebTempCs']),
          prix_ht_cd: convert_to_float(row['prixHebTempCd']),
          prix_ht_cs_ash: convert_to_float(row['prixHebTempCsa']),
          prix_ht_cd_ash: convert_to_float(row['prixHebTempCda']),
          prestation_inc_1: row['PREST1'].to_i,
          prestation_inc_2: row['PREST2'].to_i,
          prestation_inc_3: row['PREST3'].to_i,
          prestation_inc_4: row['PREST4'].to_i,
          prestation_inc_5: row['PREST5'].to_i,
          prestation_inc_6: row['PREST6'].to_i,
          prestation_inc_7: row['PREST7'].to_i,
          prestation_inc_8: row['PREST8'].to_i,
          prestation_inc_9: row['PREST9'].to_i,
          prestation_inc_10: row['PREST10'].to_i,
          prestation_inc_11: row['PREST11'].to_i,
          autre_prestation_inc: row['AUTRE_PRESTATION_INCLUSE'],
          prestation_sup_1: row['PRESTSUS1'].to_i,
          tarif_prestation_sup_1: convert_to_float(row['PRIX_LINGE']),
          unite_de_tarif_prestation_sup_1: row['UNITE_PRIX_LINGE'],
          prestation_sup_2: row['PRESTSUS2'].to_i,
          prestation_sup_3: row['PRESTSUS3'].to_i,
          prestation_sup_4: row['PRESTSUS4'].to_i,
          prestation_sup_5: row['PRESTSUS5'].to_i,
          prestation_sup_6: row['PRESTSUS6'].to_i,
          prestation_sup_7: row['PRESTSUS7'].to_i,
          prestation_sup_8: row['PRESTSUS8'].to_i,
          prestation_sup_9: row['PRESTSUS9'].to_i,
          prestation_sup_10: row['PRESTSUS10'].to_i,
          prestation_sup_11: row['PRESTSUS11'].to_i,
          autres_prestation_sup: row['AUTRES_PRIX_OU_PRESTATIONS'],
          tarif_dependance_gir_12: convert_to_float(row['TARIF_GIR_12']),
          tarif_dependance_gir_34: convert_to_float(row['TARIF_GIR_34']),
          tarif_dependance_gir_56: convert_to_float(row['TARIF_GIR_56']),
          date_maj_prix: row['DATE_MAJ']
        )
      else
        puts "Aucun établissement trouvé pour FINESS: #{finesset}"
      end
    end
  end

  def self.convert_to_float(value)
    # Remplacez la virgule par un point pour assurer une conversion correcte en float
    float_value = value.to_s.tr(',', '.').to_f
    # Si la valeur est 0 (ce qui pourrait indiquer une conversion ratée), retourner nil
    float_value.zero? ? nil : float_value
  end

end
