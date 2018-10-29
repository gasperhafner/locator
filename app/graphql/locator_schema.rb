LocatorSchema = GraphQL::Schema.define do
  query Types::QueryType
  mutation Types::MutationType
  instrument :field, GraphQL::Pundit::Instrumenter.new

  rescue_from ActiveRecord::RecordInvalid do |e|
    GraphQL::ExecutionError.new(e.record.errors.full_messages.join("\n"))
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    GraphQL::ExecutionError.new("An error occurred finding the record: #{e.message}")
  end

  rescue_from Exceptions::ActionForbiddenException do |e|
    GraphQL::ExecutionError.new("Forbidden (guest users cannot create more than one order)")
  end
end
