require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/image_generator'
require './lib/user'

class UserTest < Minitest::Test
  def test_it_exists
    image = ImageGenerator.new(20)
    user = User.new("t@gmail.com", image)
    assert_instance_of User, user
  end

  def test_attributes
    #I don't need an actual ImageGenerator object. I use a mock to stand in
    mock_image_generator = mock("image_generator")
    user = User.new("t@gmail.com", mock_image_generator)
    assert_equal "t@gmail.com", user.email
    assert_equal mock_image_generator, user.image_generator
    # The id is generated randomly, so I don't know the exact value, but I can
    # test that it is indeed and integer.
    assert_instance_of Integer, user.id
    #If I want to test and exact value then I
    # need to stub the randomness here:
    
    user.stubs(:id).returns(5)
    assert_equal 5, user.id
  end

  def test_change_id_via_user_input
    #Still don't need an actual ImageGenerator object.
    mock_image_generator = mock("image_generator")
    user = User.new("t@gmail.com", mock_image_generator)
    #Need to stub out user input that #change_id_via_user_input relies on.
    user.stubs(:get_user_input).returns(100)
    user.change_id_via_user_input
    assert_equal 100, user.id
  end

  def test_user_can_generate_image
    mock_image_generator = mock("image_generator")
    user = User.new("t@gmail.com", mock_image_generator)

    #Assert that this method is called at least once in this test
    mock_image_generator.expects(:generate_images).at_least_once # auto-verified at end of test
    user.create_images #Method #generate_images is called
  end
  # Using stubs and/or mocks, write the tests to confirm the
  # rest of the functionality that exists in ./lib/user.rb and
  # ./lib/image_generator.rb
end
