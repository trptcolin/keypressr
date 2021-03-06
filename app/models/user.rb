# This is a default user class used to activate merb-auth.  Feel free to change from a User to 
# Some other class, or to remove it altogether.  If removed, merb-auth may not work by default.
#
# Don't forget that by default the salted_user mixin is used from merb-more
# You'll need to setup your db as per the salted_user mixin, and you'll need
# To use :password, and :password_confirmation when creating a user
#
# see merb/merb-auth/setup.rb to see how to disable the salted_user mixin
# 
# You will need to setup your database and create a user.
class User
  include DataMapper::Resource
 
  property :id, Serial
  property :name, String, :nullable => true, :default => nil
  property :email, String, :nullable => true, :default => nil
  property :identity_url, String, :nullable => false, :unique => true, :unique_index => true
  property :admin, Boolean, :default => false
 
  has n, :record_times
 
  def display_name
    if self.name
      name
    else
      identity_url.gsub(/^http:\/\//, "").split(".").first
    end
  end
  
  def admin?
    admin
  end

  def password_required?
    false
  end
end
