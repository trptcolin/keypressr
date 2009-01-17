module Merb
  module GlobalHelpers
    def ensure_admin
      # throw :halt, '<h1>You are not authorized to do that!</h1>' unless admin?
      unless admin?
        redirect url(:login), :message => { :notice => "You are not authorized to do that!" } 
        throw :halt
      end
    end

    def admin?
      session.authenticated? && session.user.admin?
    end
  end
end
