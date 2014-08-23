class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_site
    Site.where(id: params['site_id']).first if params['site_id']
  end
end
