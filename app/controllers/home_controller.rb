class HomeController < ApplicationController
  skip_authorization_check
  def index

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
