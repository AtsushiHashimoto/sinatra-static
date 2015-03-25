# Sinatra-Static

## LICENCE
This software is released under the MIT License, see LICENSE.

## Download
- http://github.com/AtsushiHashimoto/sinatra-static

## Install

- Install template library that you want to use. (e.g. erb, haml, sass or coffee-script)

## How to use


1 Include sinatra-static.rb

    require '/path/to/sinatra-static.rb' 

2 Register the module as a helper

    helpers Sinatra::StaticPublish

3 Call 'static_publish' function in your sinatra application

    static_publish(src_uri_path,tar_uri_path, [reference_file1, ...])
    
## Example
- [Check out an example!](examples/app.rb)
- [Readme for the example](examples/readme.md)