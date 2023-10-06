

# app/helpers/navbar_helper.rb

module NavbarHelper
  def navbar_partial_path
    if controller.controller_name == 'prospects' && controller.action_name == 'new'
      'shared/navbar_green'
    else
      'shared/navbar'
    end
  end
end
