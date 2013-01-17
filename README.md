team461/website
===============

This is the semi-final code for the website.
We're going to try to keep everything in this pertinent to the final production;
this means that most of the things in this project will be important to the final
production (though we will probably not put the actual database things, the actual
pages will not be put into this, but the framework to create the pages automatically
and read them from the database when added will be there).
This means no actual content will be added, as we're creating this as a framework.
When _on_ the server, scripts will be used to add content automatically from the old website, but the layout and such will remain.

Eventually, this will be up at [our site](http://boilerinvasion.org).

Installation
------------

    git clone git@github.com/team461WBI/website.git

To fetch the repo. Change to directory, then do

    bundle install
    rake db:migrate

Then install nodejs through your package manager of choice (or however 
you want to, really, just make sure it works).

Then go set up `config/initializers/twitter.rb`.
See the .gitignore in that directory for more info.
Once you have the correct authentication stuffs in there,
you should be able to do `rails server` and access the server at port 3000

Setting up logins
-----------------

When initially configured, the database contains no users.
And, when the website is initially loaded, and there are no users,
let alone an administrator user, you cannot create more users using
the `/sign_up` page (whose location may change)

To add a user, and work around this, you should probably run

    rails console

And within it, run

    User.create :name => "[administrator's name (e.g. Administrator)]", :email => "[administrator's email address (e.g. admin@blah.com)]", :password => "[administrator password, needs to be that, and is not hidden when entering (so avert others' eyes)]", :admin => true

The `:admin => true` is the most important part of that command,
as it sets the user to an administrator.
On the sidebar, the Sign Up link (which directs to the user creation
panel) will only be displayed if the user-logged-in-as is an administrator.

Of course, all of the above information is subject to change as the stuff
does, so this may be outdated (direct all issues to our [issues page](https://github.com/team461WBI/website/issues))
