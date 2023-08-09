require "test_helper"

class ConfigurationTest < Minitest::Test

  def setup
    Paddle.config.api_key = "abc123"
  end

  def test_api_key
    assert_equal "abc123", Paddle.config.api_key
  end

  def test_production_environment
    Paddle.config.environment = :production
    assert !Paddle.config.url.nil?
    assert_equal Paddle.config.url, "https://api.paddle.com"
  end

  def test_development_environment
    Paddle.config.environment = :development
    assert !Paddle.config.url.nil?
    assert_equal Paddle.config.url, "https://sandbox-api.paddle.com"
  end

  def test_sandbox_environment
    Paddle.config.environment = :sandbox
    assert !Paddle.config.url.nil?
    assert_equal Paddle.config.url, "https://sandbox-api.paddle.com"
  end

end
