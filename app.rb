require 'sinatra'
require 'haml'
require 'json'

class Object
  def to_oc
    oc = JSON.pretty_generate(self, indent: '    ')
      .gsub('{', '@{')
      .gsub('[', '@[')
      .gsub(/(:\s|^\s*)([0-9]+)/, "\\1@\\2")
      .gsub(/(:\s|^\s*)null/, "\\1[NSNull null]")
      .gsub(/"([^"]+)"/, '@"\\1"')
  end
end

get '/' do
  expires 60*10, :public

  @json = '{"convert": "JSON", "to": [1, 2, null, "Objective-C"]}'
  @result = JSON.parse(@json).to_oc
  haml :index
end

post '/' do
  @json = params[:json]

  begin
    @result = JSON.parse(@json).to_oc
    @line_count = @result.split("\n").size
    haml :result
  rescue
    haml :error
  end
end
