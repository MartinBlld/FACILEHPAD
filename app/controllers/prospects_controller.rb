class ProspectsController < ApplicationController

  def new
    @prospect_form = ProspectForm.new
  end

  def create
    cleaned_params = clean_array_params(prospect_form_params)
    @prospect_form = ProspectForm.new(cleaned_params)

    if @prospect_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @prospect_forms = ProspectForm.all
  end

  def show
    @prospect_form = ProspectForm.find(params[:id])
    @etablissements_proches = Etablissement.near([@prospect_form.latitude_de_recherche, @prospect_form.longitude_de_recherche], @prospect_form.rayon_de_recherche).limit(7)
    if @etablissements_proches.empty?
      @etablissements_proches = Etablissement.near([@prospect_form.latitude_de_recherche, @prospect_form.longitude_de_recherche], @prospect_form.rayon_de_recherche + 10)
    else
      @etablissements_proches
    end
  end

  private

  def prospect_form_params
    params.require(:prospect_form).permit(
      :email, :telephone, :adresse_de_recherche, :rayon_de_recherche,
      :nombre_de_places, :connaissance_gir, :echelle_gir, :etat_de_sante,
      :conditions_medicales_particulieres, :maladie_degenerative,
      :fréquence_des_visites, :etat_du_dossier_administratif,
      :budget_mensuel, :commentaires,
      :type_de_chambre,
      :animal_de_compagnie,
      :connaissance_gir,
      :revenu_mensuel_mini,
      :echelle_gir,
      services_indispensables: [],
      services_souhaites: [],
      type_de_residence: [],
      confession_de_la_residence: [],
      interets_pour_sorties: [],
      interets_pour_activites: [],
      besoins_alimentaires: [],
      meubles_et_objets_personnels: [],
      besoins_spécifiques_aménagement: [],
      besoins_spécifiques_visiteurs: [],
      aides_financieres_déjà_obtenues_ou_en_cours: [],
      aides_financieres_a_demander: []
    )
  end


  def clean_array_params(params)
    array_attributes = [
      :services_indispensables,
      :services_souhaites,
      :type_de_residence,
      :confession_de_la_residence,
      :interets_pour_sorties,
      :interets_pour_activites,
      :besoins_alimentaires,
      :besoins_spécifiques_aménagement,
      :besoins_spécifiques_visiteurs,
      :aides_financieres_déjà_obtenues_ou_en_cours,
      :aides_financieres_a_demander
    ]
    array_attributes.each do |attribute|
      params[attribute]&.reject!(&:blank?)
    end
    params
  end

end
