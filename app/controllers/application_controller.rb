class ApplicationController < ActionController::Base
    before_action :basic_auth
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    private
  
    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: [:nickname, :email, :family_name, :last_name, :family_name_kana, :last_name_kana,
                                               :birth_date, :prefecture_id, :gender_identity_id, :sexual_orientation_1_id, 
                                               :sexual_orientation_2_id,:sexual_orientation_3_id,:sexual_orientation_4_id,
                                               :sexual_orientation_5_id, :sexual_orientation_6_id, :sexual_orientation_7_id,
                                               :height, :body_type_id, :purpose_id, :self_pr, :image])
    end
  end
