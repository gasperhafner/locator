module Api
  class Base
    attr_reader :conn, :response_code, :response_body

    def api_get(path, params = {})
      Rails.logger.info "GET #{path}, params: #{params.to_json}"
      resp = conn.get(path, params)
      handle_resp(resp)
    end

    def api_patch(path, data = {})
      Rails.logger.info "PATCH #{path}, data: #{data.to_json}"
      resp = conn.patch(path) do |req|
        req.body = data.to_json
      end
      handle_resp(resp)
    end

    def api_post(path, data = {})
      Rails.logger.info "POST #{path}, data: #{data.to_json}"
      resp = conn.post(path) do |req|
        req.body = data.to_json
      end
      handle_resp(resp)
    end

    def api_put(path, data = {})
      Rails.logger.info "PUT #{path}, data: #{data.to_json}"
      resp = conn.put(path) do |req|
        req.body = data.to_json
      end
      handle_resp(resp)
    end

    def api_delete(path, params = {})
      Rails.logger.info "DELETE #{path}, params: #{params.to_json}"
      resp = conn.delete(path, params)
      handle_resp(resp)
    end

    def handle_resp(resp)
      @response_body = resp.body.presence ? JSON.parse!(resp.body) : nil
      @response_code = resp.status

      case resp.status
      when 200..299
        @response_body
      when 404
        raise Api::NotFoundError.new(resp), "Resource not found: #{resp.body}"
      when 400..499
        raise Api::ClientError.new(resp), "Server returned #{resp.status}: #{resp.body}"
      when 500..599
        raise Api::ServerError.new(resp), "Server returned #{resp.status}: #{resp.body}"
      else
        raise Api::Error.new(resp), "Server returned #{resp.status}: #{resp.body}"
      end
    end
  end
end
