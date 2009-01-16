class Users < Application

  before :ensure_authenticated

  def index
    render
  end
  
  def show(id)
    @user = User.first(:id => id)
    render    
  end
  
end
