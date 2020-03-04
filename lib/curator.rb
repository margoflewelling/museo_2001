class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def photographs_by_artist
    @artists.reduce({}) do |artist_with_photos, artist|
      artist_with_photos[artist] = @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
      end 
    artist_with_photos
    end
  end

end
