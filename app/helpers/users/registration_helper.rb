module Users::RegistrationHelper

  def set_gender
    if params[:user].try(:[], :gender)
      sanitize 'checked="checked"'
    end
  end

  def set_weight
    # byebug
    if params[:user].try(:[], :weight)
      sanitize 'value="<%= params[:user][:weight] %>"'
    end
  end
  
end
