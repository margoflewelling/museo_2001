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

end
