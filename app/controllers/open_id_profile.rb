class OpenIdProfile < Application
  before :ensure_authenticated, :only => [ :login ]
  before :ensure_openid_url, :only => [ :register ]
 
  def login
    redirect "/", :message => { :notice => "I see you're back for more. Good luck and good pressin'!" }
  end
 
  def logout
    session[:user] = nil
    redirect "/", :message => { :notice => "We'll miss you! Press again soon!" }
  end
 
  def register
    attributes = {
      :name => session['openid.nickname'],
      :email => session['openid.email'],
      :identity_url => session['openid.url'],
    }
 
    @user = Merb::Authentication.user_class.first_or_create(
      attributes.only(:identity_url, :name, :email)
    )
    debugger

    if @user.update_attributes(attributes)
      session.user = @user
      redirect "/", :message => { :success => 'Signup was successful', :notice => "Welcome! Get to pressin'!" }
    else
      render :template => "/", :status => 422, :message => { :notice => 'There was an error while creating your user account' }
    end

  end
 
  private
 
  def ensure_openid_url
    throw :halt, redirect(url(:login)) if session['openid.url'].nil?
  end
  
end
