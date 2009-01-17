class Languages < Application

  before :ensure_authenticated, :exclude => [:index]
  before :ensure_admin, :exclude => [:index]
  
  def index
    @all_languages = Language.all.sort_by{ |l| l.name }
    render
  end
  
  def new
    @language = Language.new
    render    
  end
  
  def edit
    @language = Language.first(:id => params[:id])
    render
  end
  
  def create
  	@language = Language.new(params[:language])

  	if @language.save
  		message[:notice] = "Language saved successfully!"
  		redirect "/languages/index"
  	else
      # debugger
  		message[:error] = "There was a problem saving the language: #{@language.errors.full_messages}"
  		render :template => "languages/new"
  	end
  	
  	rescue Exception => ex
  		message[:error] = "EXCEPTION: #{ex.message}"
  		render :template => "languages/new"
  end
  
  def destroy
    @language = Language.first(:id => params[:id])    
    @language.destroy
    redirect "/languages/index"
  end
end
