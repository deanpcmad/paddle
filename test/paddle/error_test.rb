class ErrorTest < Minitest::Test
  def test_generic_error
    error = Paddle::Error.new({ "error" => { "code" => 123, "detail" => "Paddle error message" } }, 409)

    assert_equal "Error 409: Paddle error message '123'", error.message
  end

  def test_bad_request_error
    error = Paddle::ErrorFactory.create(
      { 'error': { "code" => 123, "detail" => "Paddle error message" } },
      400
    )

    assert_equal "Error 400: Your request was malformed. '123'", error.message
  end

  def test_authentication_missing_error
    error = Paddle::ErrorFactory.create(
      { 'error': {} },
      401
    )

    assert_equal "Error 401: You did not supply valid authentication credentials.", error.message
  end

  def test_customer_already_exists_error
    error = Paddle::ErrorFactory.create(
      { "error": { "type": "request_error", "code": "customer_already_exists", "detail": "customer email conflicts with customer of id ctm_01j2c063nh77j5qx5nwhhqkdcg", "documentation_url": "https://developer.paddle.com/v1/errors/customers/customer_already_exists" }, "meta": { "request_id": "f0815456-2b6e-49f5-963d-4772ccfa1630" } },
      409
    )

    assert_kind_of Paddle::CustomerAlreadyExistsError, error

    assert_equal "Error 409: customer email conflicts with customer of id ctm_01j2c063nh77j5qx5nwhhqkdcg 'customer_already_exists'", error.message
  end
end
