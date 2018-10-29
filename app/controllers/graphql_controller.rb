class GraphqlController < ActionController::Base
  include Knock::Authenticable

  def index
    render json: {
      msg: 'API accessible on /graphql'
    }
  end

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    context = {
      current_user: self.current_user,
      controller: self
    }

    result = LocatorSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )

    render json: result
  end

  private

  def current_user
    token = params[:token] || request.headers['Authorization'].split.last
    Knock::AuthToken.new(token: token).current_user
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
