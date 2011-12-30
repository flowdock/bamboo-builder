This small Sinatra app receives GitHub service hook requests, and turns them into Bamboo REST API calls.
It allows you to run your build when any of the branches changes.

Bamboo configuration
--------------------

Configure your plan's source repository to use a variable as the branch name: go to Configure Plan - Source Repositories - Git,
and enter ${bamboo.buildBranch} as "Branch".

Create an account that is allowed to trigger the build, much like you would do with GitHub's own Bamboo service hook (that doesn't
support branches).

Environment configuration
-------------------------

The Sinatra application uses the following environment variables:

* BAMBOO\_USERNAME, for example "builder" (the one you created in the previous section)
* BAMBOO\_PASSWORD (also created in the previous section)
* BAMBOO\_HOST, for example "https://sub.domain.com:8443/" (protocol, hostname and port are all handled)

Running locally
---------------

Configure the environment variables as specified above. Then simply:

* `gem install bundler`
* `bundle install`
* `ruby bamboo-builder.rb`

Deploying in Heroku
-------------------

* Create an account at [Heroku](http://heroku.com/)
* Install the gem, `gem install heroku`
* Run `heroku login`
* Clone this repo `git clone git://github.com/flowdock/bamboo-builder`
* `cd /path/to/bamboo-builder`
* `heroku create [optional-app-name]`
* `heroku config:add BAMBOO_USERNAME="<username>" BAMBOO_PASSWORD="<password>" BAMBOO_HOST="<host>"`
* `git push heroku master`

GitHub configuration
--------------------

Go to your repository's Admin page and add a Service Hook. It should point to http://yourapp.heroku.com/bambooBuild/BUILDKEY,
where BUILDKEY is the Bamboo build key consisting of project name and plan name, for example "MYPROJECT-MYPLAN".

Save settings and press the "Test Hook" button test your setup. For debugging, check out `heroku logs`.

Authors
-------

Written by Otto Hilska from [Flowdock](http://www.flowdock.com/)
