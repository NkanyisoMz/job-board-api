class Api::V1::BaseController < ApplicationController


    SECRET_KEY = Rails.application.secret_key_base
    
    def encode_token(payload)
        JWT.encode(payload, SECRET_KEY)
    end
end