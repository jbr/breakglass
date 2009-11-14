class ManifestsController < ApplicationController
  layout nil
  def index
    if logged_in?
      render :content_type => 'text/cache-manifest'
    else
      render :status => 404, :nothing => true
    end
  end
end