require 'digest/sha1'   
    
class User < ActiveRecord::Base
 
  # Validations
  validates_presence_of :login
  validates_length_of :login, :within => 3..40
  validates_uniqueness_of :login, :case_sensitive => false
  validates_length_of :name, :maximum => 100

  # Relationships
  has_and_belongs_to_many :roles

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation
                                                                          
  # Authenticates a user by their login name and unencrypted password. Ret
  def self.authenticate(login, password)                                  
    u = find_in_state :first, :active, :conditions => { :login => login } 
    u && u.authenticated?(password) ? u : nil                             
  end                                                                     
                                                                          
  # Check if a user has a role.                                           
  def has_role?(role)                                                     
    list ||= self.roles.map(&:name)                                       
    list.include?(role.to_s) || list.include?('admin')                    
  end                                                                     
                                                                          
  # Overwrite password_required for open id                               
  def password_required?                                                  
    new_record? ? (crypted_password.blank? || !password.blank?) : !passwor
  end                                                                     
                                                                          
  protected                                                               
                                                                          
  def make_activation_code                                                
    self.deleted_at = nil                                                 
    self.activation_code = self.class.make_token                          
  end                                                                     
end                                                                       