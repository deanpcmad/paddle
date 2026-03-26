require "test_helper"

class ConfigurationTest < Minitest::Test
  def setup
    Paddle.config.api_key = "abc123"
  end

  def test_api_key
    assert_equal "abc123", Paddle.config.api_key
  end

  def test_environment_should_default_to_production
    Paddle.config.environment = nil
    assert_equal Paddle.config.url, "https://api.paddle.com"
  end

  def test_production_environment
    Paddle.config.environment = :production
    assert_equal Paddle.config.url, "https://api.paddle.com"
  end

  def test_development_environment
    Paddle.config.environment = :development
    assert_equal Paddle.config.url, "https://sandbox-api.paddle.com"
  end

  def test_sandbox_environment
    Paddle.config.environment = :sandbox
    assert_equal Paddle.config.url, "https://sandbox-api.paddle.com"
  end

  def test_version
    Paddle.config.version = 2
    assert_equal 2, Paddle.config.version
  end

  def test_connection_options_defaults_to_empty_hash
    assert_equal({}, Paddle.config.connection_options)
  end

  def test_connection_options_passes_timeout_to_faraday
    Paddle.config.connection_options = { request: { timeout: 10, open_timeout: 5 } }
    Paddle::Client.instance_variable_set(:@connection, nil)

    conn = Paddle::Client.connection
    assert_equal 10, conn.options.timeout
    assert_equal 5, conn.options.open_timeout
  ensure
    reset_client_connection
  end

  def test_connection_options_passes_proxy_to_faraday
    Paddle.config.connection_options = { proxy: "http://localhost:8080" }
    Paddle::Client.instance_variable_set(:@connection, nil)

    conn = Paddle::Client.connection
    assert_equal "http://localhost:8080", conn.proxy.uri.to_s
  ensure
    reset_client_connection
  end

  private

  # Rebuild a clean sandbox connection so VCR-backed tests in other
  # files always hit sandbox-api.paddle.com regardless of test ordering.
  def reset_client_connection
    Paddle.config.connection_options = {}
    Paddle.config.environment = :sandbox
    Paddle::Client.instance_variable_set(:@connection, nil)
    Paddle::Client.connection # force memoization with sandbox URL
  end
end
