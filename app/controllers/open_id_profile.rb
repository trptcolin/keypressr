class OpenIdProfile < Application
  before :ensure_authenticated, :only => [ :login ]
  before :ensure_openid_url, :only => [ :register ]
 
  def login
    # if the user is logged in, then redirect them to their profile
    message[:notice] = 'You are now logged in.'
    redirect resource(session.user)
  end
 
  def logout
    session[:user] = nil
    message[:notice] = 'You are now logged out.'
    redirect "/"
  end
 
  def register
    attributes = {
      :name => session['openid.nickname'],
      :email => session['openid.email'],
      :identity_url => session['openid.url'],
    }
 
    @user = Merb::Authentication.user_class.first_or_create(
      attributes.only(:identity_url),
      attributes.only(:name, :email)
    )
 
    if @user.update_attributes(attributes)
      session.user = @user
      redirect resource(session.user), :message => { :success => 'Signup was successful', :notice => 'You are now logged in' }
    else
      message[:error] = 'There was an error while creating your user account'
      render :template => '/', :status => 422
    end
  end
 
  private
 
  def ensure_openid_url
    throw :halt, redirect(url(:login)) if session['openid.url'].nil?
  end
  
end