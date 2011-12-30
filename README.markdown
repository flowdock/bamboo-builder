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

Also, branch names are mapped to Bamboo build keys using environment variables. For example:

* BRANCH\_bamboo-builder, build key for branch "bamboo-builder", for example "MYPROJECT-MYPLAN"

Deploying in Heroku
-------------------

* Create an account at [Heroku](http://heroku.com/)
* Install the gem, `gem install heroku`
* Run `heroku login`
* Clone this repo `git clone git://github.com/flowdock/bamboo-builder`
* `cd /path/to/bamboo-builder`
* `heroku create [optional-app-name]`
* `heroku config:add BAMBOO_USERNAME="<username>" BAMBOO_PASSWORD="<password>" BAMBOO_HOST="<host>" BRANCH_my-backend="<plan>"
* `git push heroku master`

For debugging, check out `heroku logs`.

Authors
-------

Written by Otto Hilska from [Flowdock](http://www.flowdock.com/)
