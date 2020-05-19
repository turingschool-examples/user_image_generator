require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/image_generator'
require './lib/user'

class UserTest < Minitest::Test
  def test_it_exists
    # I pass a real image generator object - this is potentially slow and costly
    # Lets mock this object whenever possible
    image = ImageGenerator.new(20)
    user = User.new("t@gmail.com", image)
    assert_instance_of User, user
  end

  def test_attributes
    #I don't need an actual ImageGenerator object. I use a mock instead.
    mock_image_generator = mock("image_generator")
    # Note that the argument I pass mock can be any string identifier I choose
    # I use "image_generator" to help me remember which object I'm mocking.
    user = User.new("t@gmail.com", mock_image_generator)
    assert_equal "t@gmail.com", user.email
    assert_equal mock_image_generator, user.image_generator
    # The id is generated randomly, so I don't know the exact value, but I can
    # test that it is indeed and integer.
    assert_instance_of Integer, user.id
    # If I want to test an exact value then I
    # need to stub the randomness here:
    user.stubs(:id).returns(5)
    assert_equal 5, user.id
    # This isn't a great test. If I stub a method, I can be sure that that method
    # will return my stubbed value. Stubbing is more powerful when used
    # in conjunction with methods that rely on other methods that have underlying
    # randomness or user input required.
  end

  def test_change_id_via_user_input
    # I still don't need an actual ImageGenerator object.
    mock_image_generator = mock("image_generator")
    user = User.new("t@gmail.com", mock_image_generator)
    # Need to stub out user input that the method #change_id_via_user_input relies on.
    user.stubs(:get_user_input).returns(100)
    user.change_id_via_user_input
    assert_equal 100, user.id
    # Now I can be sure that when I call #change_id_via_user_input that my id
    # indeed does change to the value that is returned by the #get_user_input
    # method. This is a more powerful use of stubbing.
  end

  def test_user_can_generate_image
    mock_image_generator = mock("image_generator")
    user = User.new("t@gmail.com", mock_image_generator)
    # Assert that this method is called at least once in this test
    mock_image_generator.expects(:generate_images).at_least_once # auto-verified at end of test
    # The method #generate_images is called on the mock ImageGenerator object
    # when I invoke the user instance method #create_images
    user.create_images
    #At the end of the test is where line 55 is verified
  end
  # Using stubs and/or mocks, write the tests to confirm the
  # rest of the functionality that exists in ./lib/user.rb
end
