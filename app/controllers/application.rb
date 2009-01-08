class Application < Merb::Controller
  before :get_languages_with_code

  private
  
  def get_languages
    @languages = Language.all
  end
  
  def get_languages_with_code
    # @languages = Language.find_by_sql("SELECT languages.*, texts.* FROM languages LEFT JOIN texts ON languages.id=texts.language_id")
    @languages = Language.find_by_sql("SELECT languages.*, texts.* FROM languages INNER JOIN texts WHERE languages.id = texts.language_id")
    
    # all(:includes => [:texts], :texts.not => [])
  end

end
