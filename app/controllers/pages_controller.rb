class PagesController < ApplicationController
  def home
  end

  def new
    @prospect_form = ProspectForm.new
  end
end
