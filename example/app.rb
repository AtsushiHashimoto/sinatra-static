require 'sinatra/base'
require 'haml'

require '../lib/sinatra/sinatra-static.rb'

class MyApp < Sinatra::Base

  configure do
    helpers Sinatra::StaticPublish

  end

  # Dynamic Contents to be converted into static files)
  get '/contents/*.*' do |file,template|
    path = '/contents/' + file
    @title = file
    send template, :"#{path}"
  end

  # Link to convert the dynamic contents into static files
  get '/publish' do
    buf = []

    targets = Dir.glob(settings.views + '/contents/**/*.haml')
    targets.each{|f|
      src_rel_path = f.gsub(settings.views,'')

      tar_rel_path = '/static/' + src_rel_path.gsub('.haml','.html')
      src_path, result, option = static_publish(src_rel_path,tar_rel_path, [f])
      buf << [src_path,result,option]
    }
    response_html = ""
    buf.each{|b|
      response_html += haml "%li #{b[0]} #{b[1]} #{b[2]}\n"
    }
    return response_html
  end

end

MyApp.run!