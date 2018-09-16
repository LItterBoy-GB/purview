require "test_helper"

class PurviewTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Purview::VERSION
  end

  def test_it_does_something_useful
    Purview::CLI.run
  end
end
