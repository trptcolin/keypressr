class Application < Merb::Controller
  before :get_languages_with_code
  before :get_current_user

  private
  
  def get_all_languages
    @all_languages = Language.all
  end
  
  def get_languages_with_code
    # @languages = Language.find_by_sql("SELECT languages.*, texts.* FROM languages LEFT JOIN texts ON languages.id=texts.language_id")
    @languages = Language.find_by_sql("SELECT languages.*, texts.* FROM languages INNER JOIN texts WHERE languages.id = texts.language_id")
    
    # all(:includes => [:texts], :texts.not => [])
  end

  def get_current_user
    @current_user ||= User.first(:id => session[:user])
  end

end
