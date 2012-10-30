class MenusController < ActionController::Base
  layout nil

  skip_authorization_check :only => [:extrudertop, :components]

end