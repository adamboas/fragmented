class HomeController < ApplicationController
  def index
    @fragment = Fragment.find(2)
  end

end
