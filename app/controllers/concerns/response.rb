module Response
  def json_response(object, message, status = 200)
    render json: { result: object, message: message }, status: status
  end
end
