require 'minitest/autorun'
require 'minitest/pride'
require './lib/image_generator'

class ImageGeneratorTest < Minitest::Test

  def test_it_exists
    image_generator = ImageGenerator.new(2500)
    assert_instance_of ImageGenerator, image_generator
  end

  def test_attributes
    image_generator = ImageGenerator.new(2500)
    assert_equal 2500, image_generator.max_image_value
  end
  # Using stubs and/or mocks, write the tests to confirm the functionality
  # that exists in ./lib/image_generator.rb
end
