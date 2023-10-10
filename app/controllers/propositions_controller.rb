class PropositionsController < ApplicationController

  def show
    @proposition = Proposition.find(params[:id])
    @prospect_form = @proposition.prospect_form # Assurez-vous que cette ligne définit correctement @prospect_form
    @etablissement_propositions = @proposition.etablissement_propositions
  end

end
