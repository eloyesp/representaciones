class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'  
    
  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Acceso no permitido!"  
    redirect_to root_url  
  end  
end

