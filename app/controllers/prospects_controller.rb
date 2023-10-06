class ProspectsController < ApplicationController


  def new
    @prospect_form = ProspectForm.new
  end

  def create
    @prospect_form = ProspectForm.new(prospect_form_params)
    if @prospect_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def prospect_form_params
    params.require(:prospect_form).permit(:email, :telephone, :echelle_gir,
      :ville_actuelle_senior, :adresse_de_recherche, :code_postal,:rayon_de_recherche,
      :nombre_de_places, :services_indispensables, :services_souhaites, :type_de_residence,
      :confession_de_la_residence, :type_de_chambre, :animal_de_compagnie,
      :besoins_alimentaires, :etat_de_sante, :conditions_medicales_particulieres,
      :maladie_degenerative, :meubles_et_objets_personnels, :besoins_spécifiques_aménagement,
      :fréquence_des_visites, :besoins_spécifiques_visiteurs, :interets_pour_sorties,
       :interets_pour_activites, :etat_du_dossier_administratif, :budget_mensuel,
       :aides_financieres_déjà_obtenues_ou_en_cours, :aides_financieres_a_demander,
       :commentaires)
  end

end
