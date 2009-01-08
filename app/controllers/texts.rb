class Texts < Application

  before :ensure_authenticated
  before :get_languages
  
  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    @texts = Text.all
    @languages = @texts.map{|t| t.language}.uniq
    render
  end
  
  def new
    @text = Text.new
    render    
  end
  
  def edit
    @text = Text.find(params[:id])
    render
  end
  
  def create
  	@text = Text.new(params[:text])
  	@text.attachment = params[:attachment]

  	if @text.save
  		message[:notice] = "Text saved successfully!"
      redirect "/texts/index"
  	else
      # debugger
  		message[:error] = "There was a problem saving the text: #{@text.errors.full_messages}"
  		render :template => "texts/new"
  	end
  	#@text = Text.new
  	#render params["attachment"].inspect
    #fp = File.open(params[:text][:attachment][:tempfile].path)
    #filename = params[:text][:attachment][:filename]
  	#render :action => "index"
  	
  	rescue Exception => ex
  		message[:error] = "EXCEPTION: #{ex.message}"
  		render :template => "texts/new"
  end
  
  def destroy
    @text = Text.first(:id => params[:id])    
    @text.destroy
    redirect "/texts/index"
  end
  
end
