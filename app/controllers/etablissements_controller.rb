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

  def initiate_price_and_services_database
    records = PriceServicesEhpad.fetch_and_update_data
    if records.is_a?(Array) && records.present?
      PriceServicesEhpad.update_etablissements(records)
      flash[:notice] = "Prix et services ajoutés!"
    else
      flash[:alert] = "Erreur : les données n'ont pas pu être récupérées ou mises à jour."
    end
    redirect_to etablissements_path
  end



def index
  @etablissements = Etablissement.all
end

def show
  @etablissement = Etablissement.find(params[:id])
end



end
