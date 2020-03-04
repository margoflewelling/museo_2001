require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'


class CuratorTest < Minitest::Test

  def setup
    @curator = Curator.new

    @photo_1 = Photograph.new({
                               id: "1",
                               name: "Rue Mouffetard, Paris (Boy with Bottles)",
                               artist_id: "1",
                               year: "1954"
                              })
    @photo_2 = Photograph.new({
                               id: "2",
                               name: "Moonrise, Hernandez",
                               artist_id: "2",
                               year: "1941"
                              })
    @photo_3 = Photograph.new({
                               id: "3",
                               name: "Identical Twins, Roselle, New Jersey",
                               artist_id: "3",
                               year: "1967"
                               })
    @photo_4 = Photograph.new({
                               id: "4",
                               name: "Monolith, The Face of Half Dome",
                               artist_id: "3",
                               year: "1927"
                              })
    @artist_1 = Artist.new({
                            id: "1",
                            name: "Henri Cartier-Bresson",
                            born: "1908",
                            died: "2004",
                            country: "France"
                            })
    @artist_2 = Artist.new({
                            id: "2",
                            name: "Ansel Adams",
                            born: "1902",
                            died: "1984",
                            country: "United States"
                            })
     @artist_3 = Artist.new({
                             id: "3",
                             name: "Diane Arbus",
                             born: "1923",
                             died: "1971",
                             country: "United States"
                             })
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_attrs
    assert_equal [], @curator.photographs
    assert_equal [], @curator.artists
  end

  def test_it_can_add_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_it_can_get_photographs_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    expected = {@artist_1 => [@photo_1],
                @artist_2 => [@photo_2],
                @artist_3 => [@photo_3, @photo_4]
                }
    assert_equal expected, @curator.photographs_by_artist
  end

  def test_it_can_return_artists_with_multiple_photographs
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal ["Diane Arbus"], @curator.artists_with_multiple_photographs
  end

  def test_it_can_get_photos_from_artists_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@photo_2, @photo_3, @photo_4], @curator.photographs_taken_by_artists_from("United States")
    assert_equal [], @curator.photographs_taken_by_artists_from("Argentina")
    assert_equal [@photo_1], @curator.photographs_taken_by_artists_from("France")
  end

  def test_it_can_load_photographs_from_csv
    @curator.load_photographs("./data/photographs.csv")
    assert_equal 4, @curator.photographs.length
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, @curator.photographs[0].name
  end

  def test_it_can_load_artists_from_csv
    @curator.load_artists("./data/artists.csv")
    assert_equal 6, @curator.artists.length
    assert_equal "1929", @curator.artists.last.born
  end

  def test_can_get_photos_taken_between_date_range
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@photo_1, @photo_2], @curator.photographs_taken_between(1940..1960)
    assert_equal [@photo_4], @curator.photographs_taken_between(1920..1930)
    assert_equal [], @curator.photographs_taken_between(1900..1910)
  end

  def test_it_can_get_artists_photos_by_age
    @curator.load_artists("./data/artists.csv")
    @curator.load_photographs("./data/photographs.csv")
    diane_arbus = @curator.find_artist_by_id("3")
    expected = {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
    assert_equal expected, @curator.artists_photographs_by_age(diane_arbus)
  end

end
