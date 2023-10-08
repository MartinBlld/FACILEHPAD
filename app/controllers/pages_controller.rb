class PagesController < ApplicationController
  def home
  end

  def new
    @prospect_form = ProspectForm.new
  end

  def mentions_légales
  end

  def contact
  end
  
end
