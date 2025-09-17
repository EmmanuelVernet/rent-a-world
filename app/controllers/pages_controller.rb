class PagesController < ApplicationController
  def home
    @worlds = World.includes(:user, :tags)
  end
end
