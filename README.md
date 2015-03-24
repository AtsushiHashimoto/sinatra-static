# Sinatra-Static

## LICENCE
This software is released under the MIT License, see LICENSE.

## Download
github: http://github. /AtsushiHashimoto/sinatra-static

## Install

- Install template library that you want to use. (e.g. erb, haml, sass or coffee-script)

## How to use


1 Include sinatra-static.rb
    require '/path/to/sinatra-static.rb' 

2 Register the module as a helper 
    helpers Sinatra::StaticPublish

3 Call 'static_publish' function
    static_publish(src_uri_path,tar_uri_path, [reference_file1, ...])
    
## Example
    require 'sinatra/base'
    require 'haml'
    
    require 'lib/sinatra/sinatra-static.rb'
    
    class MyApp < Sinatra::Base
    
			configure do
				helpers Sinatra::StaticPublish
			end
    
			# Rendering source (dynamic uri)
			get '/static/*.*' do |file,template|
				path = '/static/' + file
				send template, :"#{path}"
			end
			
			# Switch link for publish static files
			get '/publish' do
				buf = []
				
				targets = Dir.glob(settings.views + '/static/**/*.haml')
				targets.each{|f|
					src_rel_path = f.gsub(settings.views,'')
					
					tar_rel_path = '/published/' + src_rel_path.gsub('.haml','.html')
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