# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can specify conditions on the placeholder by passing a hash as the second
# argument of "match"
#
#   match("/registration/:course_name", :course_name => /^[a-z]{3,5}-\d{5}$/).
#     to(:controller => "registration")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  # RESTful routes
  resources :texts
  resources :users
  resources :languages
  
  match('/about').to(:controller => 'main', :action => 'about').name(:about)
  match('/records').to(:controller => 'main', :action => 'records').name(:records)
  # Adds the required routes for merb-auth using the password slice
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")

  match('/openid/login' ).to(:controller => 'open_id_profile', :action => 'login' ).name(:openid)
  match('/openid/logout' ).to(:controller => 'open_id_profile', :action => 'logout' ).name(:logout)
  match('/openid/register').to(:controller => 'open_id_profile', :action => 'register').name(:signup)

  match('/game(/:language)').to(:controller => 'main', :action => 'game').name(:game)
  default_routes
  
  match('/').to(:controller => 'main', :action => 'index').name(:home)
end
