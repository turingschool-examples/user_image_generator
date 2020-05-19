class ImageGenerator
  def initialize(max)
    @max_image_value = max
  end

  def choose_random_number
    rand(@max_image_value)
  end

  def generate_images
    images = []
    choose_random_number.times do |num|
      images << "image#{num}"
    end
    images
  end

  def assign_unknown_max_image_value(num)
    @max_image_value = (num * choose_random_number)
  end
end
