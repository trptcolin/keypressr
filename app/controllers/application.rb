class Application < Merb::Controller
  before :get_languages_with_code
  before :get_current_user

  private
  
  def get_all_languages
    @all_languages = Language.all
  end
  
  def get_languages_with_code
    @languages = Language.all.sort_by{|l| l.name}.uniq.delete_if{|l| l.texts.empty?}
  end

  def get_current_user
    @current_user ||= User.first(:id => session[:user])
  end

end
