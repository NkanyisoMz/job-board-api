class Api::V1::BaseController < ApplicationController


    SECRET_KEY = Rails.application.secret_key_base
    
    def encode_token(payload)
        JWT.encode(payload, SECRET_KEY)
    end

    def decoded_token
        header = request.headers["Authorization"]
        if header
            token = header.split(" ")[1]
            
            
            begin
                JWT.decode(token, SECRET_KEY, true, algorithm: "HS256")
            rescue JWT::DecodeError
                nil
            end
        end
    end
    
    def current_user
        if decoded_token
            user_id = decoded_token[0]["user_id"]
            @current_user ||= User.find_by(id: user_id)
        end
    end
    
    def authorize_request
        unless current_user
            render json: {
                error: "Unauthorized"
                }, status: :unauthorized
            end
        end
    end
