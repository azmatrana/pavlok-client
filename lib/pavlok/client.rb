# frozen_string_literal: true

require_relative "client/version"

module Pavlok
  class PavlokExceptions < StandardError
    attr_reader :detail
    def initialize(message="PavlokExceptions", detail="")
      @detail = detail
      super(message)
    end
  end

  class Client
    def initialize(opts = {})
      @client_id     = opts[:client_id]
      @client_secret = opts[:client_secret]
      @redirect_uri  = opts[:redirect_uri]
      @access_token  = opts[:access_token]

      if @access_token.present?
        # if access_token is passed then you can call zap, vibrate, beep methods directly
        # do nothing
      elsif ( @client_id.blank? || @client_secret.blank? || @redirect_uri.blank? || @client_id.class != String || @client_secret.class != String || @redirect_uri.class != String )
        raise PavlokExceptions.new("client_id, redirect_uri, client_secret are required")
      end
    end

    def base_api_url
      "http://pavlok-mvp.herokuapp.com/api/v1"
    end

    def code_url
      # Get code
      "http://pavlok-mvp.herokuapp.com/oauth/authorize?client_id=#{@client_id}&redirect_uri=#{@redirect_uri}&response_type=code"
    end

    def fetch_access_token(code)
      payload = {
        "client_id": @client_id,
        "client_secret": @client_secret,
        "code": code,
        "grant_type": "authorization_code",
        "redirect_uri": @redirect_uri
      }
      res = req(Net::HTTP::Post, "http://pavlok-mvp.herokuapp.com/oauth/token", {}, payload, '')
      @access_token = res["access_token"]
      return @access_token
    end

    # Zap with a Pavlok.
    # intensity is a number
    # from 1-255 that controls the stimuli's intensity, message is a
    # string that controls the message sent with the stimuli.
    def zap(intensity=1, message='Zap')
      # intensity should be an integer and should be between 1 to 255
      check_access_token
      if (intensity.class != Integer || intensity < 1 || intensity > 255)
        raise PavlokExceptions.new("Zap intensity must be an integer and between 1-255!")
      end
      payload = { "access_token": @access_token, "reason": message }
      res = req(Net::HTTP::Post, "/stimuli/shock/#{intensity}", {}, payload)
      return res
    end

    # Beep with a Pavlok.
    # intensity is a number
    # from 1-4 that controls the stimuli's intensity, message is a
    # string that controls the message sent with the stimuli.
    def beep(intensity=1, message='Beep')
      # intensity should be an integer and should be between 1 to 4
      check_access_token
      if (intensity.class != Integer || intensity < 1 || intensity > 4)
        raise PavlokExceptions.new("Beep intensity must be an integer and between 1-4!")
      end
      payload = { "access_token": @access_token, "reason": message }
      res = req(Net::HTTP::Post, "/stimuli/beep/#{intensity}", {}, payload)
      return res
    end

    # Vibrate with a Pavlok.
    # intensity is a number
    # from 1-255 that controls the stimuli's intensity, message is a
    # string that controls the message sent with the stimuli.
    def vibration(intensity=1, message='Vibration')
      # intensity should be an integer and should be between 1 to 255
      check_access_token
      if (intensity.class != Integer || intensity < 1 || intensity > 255)
        raise PavlokExceptions.new("Vibration intensity must be an integer and between 1-255!")
      end
      payload = { "access_token": @access_token, "reason": message }
      res = req(Net::HTTP::Post, "/stimuli/vibration/#{intensity}", {}, payload)
      return res
    end

    def check_access_token
      if @access_token.blank?
        raise PavlokExceptions.new("access_token is required")
      end
    end

    def req(meth_class, path, params={}, payload={}, base_url=base_api_url)
      uri = URI(base_url + path)
      uri.query = URI.encode_www_form(params)

      request = meth_class.new(uri)
      request.add_field 'Content-Type', 'application/json'
      request.body = payload.to_json

      Net::HTTP.start(uri.host, uri.port, {:use_ssl => uri.scheme == 'https'}) do |http|
        rsp = http.request(request)
        json = JSON.parse(rsp.body)
        if rsp.code.to_i != 200
          error_msg = (json.is_a?(Hash) and json.has_key?('error')) ? json['error'] : json
          raise PavlokExceptions.new("Pavlok responded with an error: #{error_msg}")
        end
        json
      end
    end

  end

end
