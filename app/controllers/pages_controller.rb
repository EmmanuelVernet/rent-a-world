class PagesController < ApplicationController
  def home
    @worlds = World.all
  end
end
