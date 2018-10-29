class Functions::Base < GraphQL::Function

  def user_service_country_code(user, args)
    return args['serviceCountry'] if args['serviceCountry'].present?
    user.present? ? user.service_country_code : "GB"
  end

  def user_service_country(user, args)
    return ServiceCountry.find_by(code: args['serviceCountry']) if args['serviceCountry'].present?
    user.present? ? user.service_country : ServiceCountry.find_by(code: "GB")
  end

  def authenticate(user)
    raise Exceptions::AuthenticationException.new unless user.present?
    true
  end

  def owner?(user, obj)
    raise Exceptions::AuthorizationException.new unless user == obj.user
    true
  end
end
