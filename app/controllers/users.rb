class Users < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    render
  end
  
  def show(id)
    @user = User.first(:id => id)
    render    
  end
  
end
