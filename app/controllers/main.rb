include Merb::ControllerMixin

class Main < Application
  
  def index
    @homepage = true
    render
  end

  def about
    render
  end

  def records
    @shortest_times = RecordTime.all(:order => [:duration.asc], :limit => 15)
    @fastest_times = RecordTime.all(:order => [:speed.desc], :limit => 15)
    render
  end

  def game
    @language = Language.first(:name => params[:language])

    language_conditions = ""
    language_conditions << "WHERE language_id=#{@language.id} " if @language

    session[:text] = nil
		rand_text = Text.find_by_sql("SELECT id FROM texts #{language_conditions}ORDER BY RAND() LIMIT 1").first
    session[:text] = rand_text.id if rand_text

    unless session[:text].nil?
      @example_text = get_text
    end
    session[:start_time] = Time.now
    @elapsed_time = "0:00"
    render
  end
  
  def check
    finished = Time.now
    @elapsed_time = finished - session[:start_time]
    @text = Text.first(:id => session[:text])
    response_text = params["response-text"].dup
    real_text = get_text
    
    unless response_text and real_text and response_text.gsub(/[ \t]+(\r\n|[\r\n])/, "\\1").gsub(/(\r\n|[\r\n])$/,"") == real_text.gsub(/[ \t]+(\r\n|[\r\n])/, "\\1").gsub(/(\r\n|[\r\n])$/,"")
      raise "Whoops!  There was a problem.  You're not cheating, are you?"
    end
    
    attributes = {:duration => @elapsed_time}
    attributes = attributes.merge(:text_id => @text.id) if @text
    attributes = attributes.merge(:user_id => session[:user]) if session[:user]
        
    if @this_time = RecordTime.create(attributes)
      @best_times = @text.record_times(:order => [:duration], :limit => 10)#.sort_by{|t| t.duration}
      render :layout => false
    else
      render "There was an error saving your time!", :layout => false
    end
    
  rescue Exception => ex
    render ex.message, :layout => false
  end
  
  def about
    render
  end
  
  private 
  def get_text(options={})
    file = File.open(Text.first(:id => session[:text]).attachment.path).collect
    file.join.gsub(/[ \t]+(\r\n|[\r\n])/, "\\1")#.gsub(
    #	/<(?!span class="(in)?correct")/, "&lt;"
    #).gsdeub(/>/, "&gt;")
  end
  
  def strip_end_spaces(text)
    text.gsub(/[ \t]+(\r\n|[\r\n])/, "\\1")
  end
  
end
