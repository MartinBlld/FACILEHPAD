class EtablissementsController < ApplicationController

  def initiate_database
    records = DataGouvService.fetch_data

    if records.present?
      DataGouvService.create_etablissements(records)
      redirect_to etablissements_path, notice: "Database has been initiated!"
    else
      redirect_to etablissements_path, alert: "No data to process."
    end
  rescue => e
    # Gestion des erreurs potentielles lors de l'appel du service
    redirect_to etablissements_path, alert: "Something went wrong: #{e.message}"
end


def index
  @etablissements = Etablissement.all
end


end
