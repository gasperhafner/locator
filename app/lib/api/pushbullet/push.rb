module Api::Pushbullet
  class Push < Base
    def create(params)
      api_post("pushes", params)
    end
  end
end
