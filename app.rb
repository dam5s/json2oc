require 'sinatra'
require 'haml'
require 'json'

class Object
  def to_oc
    oc = JSON.pretty_generate(self, indent: '    ')
      .gsub('{', '@{')
      .gsub('[', '@[')
      .gsub(/:\s([0-9]+)/, ": @\\1")
      .gsub(/"([^"]+)"/, '@"\\1"')
  end
end

get '/' do
  haml :index
end

post '/' do
  @json = params[:json]

  begin
    @result = JSON.parse(@json).to_oc
    haml :result
  rescue
    haml :error
  end
end
