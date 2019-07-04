module Users::RegistrationHelper

  def set_gender
    if params[:user].try(:[], :gender)
      sanitize 'checked="checked"'
    end
  end

  def male?
    if params[:user] != nil && params[:user][:gender] == "Male"
      sanitize 'checked="checked"'
    end
  end
  
  def female?
    if params[:user] != nil && params[:user][:gender] == "Female"
    sanitize 'checked="checked"'
    end
  end
  


end
