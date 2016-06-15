require 'faraday/http_error/version'
require 'faraday/http_error/raise_error'

module Faraday
  class HttpError < StandardError
    attr_reader :body

    def initialize(body = nil)
      @body = body
      message = "#{body}\n#{self.class.name} - " \
        "version #{Faraday::HttpError::VERSION}"

      super(message)
    end

    def self.from_response(response)
      status   = response[:status].to_i
      body     = response[:body]

      if (klass = class_error_for_status(status))
        # TODO: improve the error message
        klass.new(body)
      end
    end

    def self.class_error_for_status(http_status)
      case http_status
      when 400..499 then client_errors(http_status)
      when 500..599 then server_errors(http_status)
      end
    end

    def self.client_errors(http_status)
      case http_status
      when 400      then BadRequest
      when 403      then Forbidden
      when 404      then NotFound
      when 422      then UnprocessableEntity
      when 400..499 then ClientError
      end
    end

    def self.server_errors(http_status)
      case http_status
      when 500      then InternalServerError
      when 503      then ServiceUnavailable
      when 500..599 then ServerError
      end
    end

    # Raised on errors in the 400-499 range
    class ClientError < HttpError; end

    # Raised when the server returns a 400 HTTP status code
    class BadRequest < ClientError; end

    # Raised when the server returns a 422 HTTP status code
    class UnprocessableEntity < ClientError; end

    # Raised when the server returns a 403 HTTP status code
    class Forbidden < ClientError; end

    # Raised when the server returns a 404 HTTP status code
    class NotFound < ClientError; end

    # Raised on errors in the 500-599 range
    class ServerError < HttpError; end

    # Raised when the server returns a 500 HTTP status code
    class InternalServerError < ServerError; end

    # Raised when the server returns a 503 HTTP status code
    class ServiceUnavailable < ServerError; end
  end
end
