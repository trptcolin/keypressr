class Users < Application

  before :ensure_authenticated
  before :ensure_admin, :only => [:index, :show]

  def index
    render
  end
  
  def show(id)
    @user = User.first(:id => id)
    render    
  end
  
end
