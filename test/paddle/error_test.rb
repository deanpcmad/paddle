class ErrorTest < Minitest::Test
  def test_generic_error
    error = Paddle::Error.new({ "error" => { "code" => 123, "detail" => "Paddle error message" } }, 409)

    assert_equal "Error 409: Paddle error message '123'", error.message
  end

  def test_bad_request_error
    error = Paddle::ErrorFactory.create(
      { "error" => { "code" => 123, "detail" => "Paddle error message" } },
      400
    )

    assert_equal "Error 400: Your request was malformed. '123'", error.message
  end

  def test_authentication_missing_error
    error = Paddle::ErrorFactory.create(
      { "error": {} },
      401
    )

    assert_equal "Error 401: You did not supply valid authentication credentials.", error.message
  end

  def test_paddle_error_code
    error = Paddle::Error.new({ "error" => { "code" => 123, "detail" => "Paddle error message" } }, 409)

    assert_equal 123, error.paddle_error_code
  end

  def test_paddle_error_message
    error = Paddle::Error.new({ "error" => { "code" => 123, "detail" => "Paddle error message" } }, 409)

    assert_equal "Paddle error message", error.paddle_error_message
  end
end
