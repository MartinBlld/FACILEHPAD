class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :mentions_légales, :contact, :new, :qui_sommes_nous]


  def home
  end

  def new
    @prospect_form = ProspectForm.new
  end

  def mentions_légales
  end

  def contact
  end

  def qui_sommes_nous
  end

end
