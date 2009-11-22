class ManifestsController < ApplicationController
  layout nil
  def index
    if logged_in?
      render :content_type => 'text/cache-manifest'
    else
      head 404
    end
  end
end