class ArtistsController < ApplicationController
  before_action :authenticate_user!

  def new
    @artist = current_user.build_artist
  end
end
