# team461/website

This is the semi-final code for the website.
We're going to try to keep everything in this pertinent to the final production;
this means that this this repository alone will be able to run the same framework as the website. 
However, no actual content will be found here, as that is in the database, and we would like to
keep that private.

Eventually, this will be up at [our site](http://boilerinvasion.org).

## Installation

    git clone git@github.com/team461WBI/website.git

To fetch the repo. Change to directory, then do

    bundle install
    rake db:migrate

Then install nodejs through your package manager of choice (or however 
you want to, really, just make sure it works).

Then go set up `config/initializers/secret.rb`.
In this file, you need to set up the correct codes for authenticating the 
Twitter API. See [sferik/twitter](https://github.com/sferik/twitter) and 
the .gitignore in that directory for more info.
Once you have the correct twitter authentication stuffs in there,
add the line `SECRET_CODE = "ASecretCode"` which is the secret code that
users need to sign up. Also you need to add the secret code for creating
documents, like `DOCUMENT_SECRET_CODE = "AnotherSecretCode"`.

After all this, you should be able to do `rails server` and access the http server at 
port 3000. (Visit localhost:3000 in a web browser.)


## Setting up logins

When initially configured, the database contains no users.
And, when the website is initially loaded, and there are no users,
let alone an administrator user. You can create more users using
the `/sign_up` page (you can get to it by clicking on the header on
the login page), but these will have the default permissions, and no more.

To add an administrator, and work around this, you should probably run

    rails console

And within it, run

````
User.create :name => "[administrator's name (e.g. Administrator)]", 
            :email => "[administrator's email address (e.g. admin@blah.com)]", 
            :password => "[administrator password]",
            :password_confirmation => "[administrator password again]",
            :admin => true,
            :secret_code => "[the secret code from above]"
````

The `:admin => true` is the most important part of that command,
as it sets the user to an administrator.
On the sidebar, the Sign Up link (which directs to the user creation
panel) will only be displayed if the user-logged-in-as is an administrator.

Of course, all of the above information is subject to change as the stuff
does, so this may be outdated (direct all issues to our 
[issues page](https://github.com/team461WBI/website/issues))

## Contributing
If you see an improvement that should be made, you are more than welcome to
make your change on a fork and submit a pull request, or, if you are a contributor
to the repository, you could push it.
Keep in mind the following things:

* Keep it simple.
If you're submitting a larger change, spread it out over multiple commits.
This helps us know all of the changes you made and quickly reference a certain
commit that we don't like or that causes problems.

* Keep it stable.
If stuff is broken, please don't submit it.
If you need to fix more stuff before you commit, then fix more stuff before you
commit.
If you need to make a large change over time, use branches so you can keep
up-to-date and not cause problems.

* Keep it clean and consistent.
While it is a pain, it is incredibly important to keep the code consistent and clean.
If you happen to be using a coding style that is different from the project's coding
style, please make at least some effort to match the coding style.
It's relatively simple to do so.
Not only that, if you're submitting something that must to be approved, it can be seen
much more easily and effectively than if you're alternating between coding styles on a
line-by-line basis.
