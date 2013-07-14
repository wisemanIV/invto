class HomeController < ApplicationController
  private

  def use_https?
    false
  end
  
  def index

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
