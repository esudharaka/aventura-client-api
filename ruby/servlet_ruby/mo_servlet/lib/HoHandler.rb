# To change this template, choose Tools | Templates
# and open the template in the editor.

#!/sw/bin/ruby
require 'webrick'
require 'net/http'
require 'uri'
include WEBrick


# ---------------------------------------------
# Define a new class
class MoHandler  < WEBrick::HTTPServlet::AbstractServlet

  def do_GET(request, response)
    response['Content-Type'] = 'text/plain'
    response.status = 200
    response.body = Time.now.to_s + "\n"
    response.body << "we should diplay post parameters here."
 
  end

end

# ----------------------------------------------
# Create an HTTP server
s = HTTPServer.new(
  :Port            => 8002,
  :DocumentRoot    => "/usr/local/apache/htdocs/"
)

s.mount("/time", MoHandler)

# When the server gets a control-C, kill it
trap("INT"){ s.shutdown }

# Start the server
s.start
s.listeners