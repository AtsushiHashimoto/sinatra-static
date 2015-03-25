# Documentation for the example

## Tutorial
1. start up the example sinatra application.
    ruby app.rb

2. browse the contents in the normal way of sinatra
    wget http://localhost:4567/contents/test.haml
		wget http://localhost:4567/contents/directory/test2.haml

3. publish the above page as static file
		wget http://localhost:4567/publish

4. browse the published static files
    wget http://localhost:4567/static/contents/test.html
    wget http://localhost:4567/static/contents/directory/test2.html
