# Sinatra-Static

## LICENCE
This software is released under the MIT License, see LICENSE.

## Download
github: http://github. /AtsushiHashimoto/sinatra-static

## Install

- Install template library that you want to use. (e.g. erb, haml, sass or coffee-script)

## How to use

1 Put 'sinatra-static.rb' in anywhere your project.

2 Move to you project root

3 Create views/publish_targets

    mkdir views/publish_targets

4 Create your templates in views/publish_targets

5.1 (Case where you generate static files by command line tools)

5.2 (Case where you generate static files via HTTP GET)

  1 Put following code in your sinatra router

    require '/path/to/sinatra-static.rb'

    ...

    get '/publish' do
        publish_static_html 'target_dir_in_views'
    end

  2 Then access to /publish via your web browser.