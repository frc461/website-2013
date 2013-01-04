team461/website
===============

This is the semi-final code for the website.
We're going to try to keep everything in this pertinent to the final production; this 
means that most of the things in this project will be important to the final production 
(though we will probably not put the actual database things, the actual pages will 
not be put into this, but the framework to create the pages automatically and read them 
from the database when added will be there).
This means no actual content will be added, as we're creating this as a framework.
When _on_ the server, scripts will be used to add content automatically from the old 
website, but the layout and such will remain.

Installation
------------

    git clone git@github.com/team461WBI/website.git

To fetch the repo. Change to directory, then do

    bundle install
    rake db:migrate

Then go set up `config/initializers/twitter.rb`. See the .gitignore in that directory
for more info. Once you have the correct authentication stuffs in there, you should be able 
to do `rails server` and access the server at port 3000.
