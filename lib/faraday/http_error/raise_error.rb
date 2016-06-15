module Faraday
  class HttpError < StandardError
    # Faraday middleware responsible to raise an error when there's a
    # mapped error for the HTTP status code
    class RaiseError < Faraday::Response::Middleware
      private

      def on_complete(response)
        error = Faraday::HttpError.from_response(response)
        fail error if error
      end
    end
  end
end
