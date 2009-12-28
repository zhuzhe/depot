require 'pathname'

require "openid"
require 'openid/extensions/sreg'
require 'openid/extensions/pape'
require 'openid/store/filesystem'

class OpenidsController < ApplicationController
  skip_before_filter :require_admin,:require_login
  def new

  end

 def create
  begin
      identifier = params[:openid_identifier]
      if identifier.nil?
        flash[:error] = "Enter an OpenID identifier"
        redirect_to :action => 'new'
        return
      end
      oidreq = consumer.begin(identifier)
    rescue OpenID::OpenIDError => e
      flash[:error] = "Discovery failed for #{identifier}: #{e}"
      redirect_to :action => 'new'
      return
    end
  
    return_to =complete_openid_url
    realm = 'http://localhost:3000/'

    if oidreq.send_redirect?(realm, return_to)
      redirect_to oidreq.redirect_url(realm, return_to)
    else
      render :text => oidreq.html_markup(realm, return_to)
    end
end

def complete
 # FIXME - url_for some action is not necessarily the current URL.
    current_url = complete_openid_url
    parameters = params.reject{|k,v|request.path_parameters[k]}
    oidresp = consumer.complete(parameters, current_url)
    case oidresp.status
    when OpenID::Consumer::FAILURE
      if oidresp.display_identifier
        flash[:error] = ("Verification of #{oidresp.display_identifier}"\
                         " failed: #{oidresp.message}")
      else
        flash[:error] = "Verification failed: #{oidresp.message}"
      end
    when OpenID::Consumer::SUCCESS
      flash[:success] = ("Verification of #{oidresp.display_identifier}"\
                         " succeeded.")
     
     redirect_to home_path
     return
    when OpenID::Consumer::SETUP_NEEDED
      flash[:alert] = "Immediate request failed - Setup Needed"
    when OpenID::Consumer::CANCEL
      flash[:alert] = "OpenID transaction cancelled."
    else
    end
    redirect_to :action => 'new'
end
protected

def consumer
  if @consumer.nil?
      dir = Pathname.new(RAILS_ROOT).join('db').join('cstore')
      store = OpenID::Store::Filesystem.new(dir)
      @consumer = OpenID::Consumer.new(session, store)
    end
    return @consumer
  end
end
