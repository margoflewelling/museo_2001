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

  def artists_with_multiple_photographs
    artist_has_mult_photos = []
    photographs_by_artist.find_all do |artist, photos|
      artist_has_mult_photos << artist.name if photos.length > 1
    end
    artist_has_mult_photos
  end

  def photographs_taken_by_artists_from(country)
    photos_from_country = []
    photographs_by_artist.each do |artist, photos|
      if artist.country == country
        photos_from_country << photos
      end
    end
    photos_from_country.flatten
  end


end
