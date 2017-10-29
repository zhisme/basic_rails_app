class Site::AboutsController < SiteController
  def ping
    render plain: 'pong'
  end
end
