module Users::RegistrationHelper

  def set_gender
    if params[:user].try(:[], :gender)
      sanitize 'checked="checked"'
    end
  end
  
end
