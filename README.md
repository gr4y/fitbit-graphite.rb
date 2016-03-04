# Fitbit::Graphite

*DEPRECATED*: This will be replaced with [github.com/gr4y/fitbit-graphite](https://github.com/gr4y/fitbit-graphite) in the future.

The name of that project says it all, doesn't it? 
It fetches some of the data from the Fitbit API and sends it to an Graphite / Carbon instance. 

I won't promise anything. That project is just here on GitHub because it's a small little project I hacked together in about 2 days after fiddling with RDDs for over two months. 

I won't write any tests, because mocking the webservices is just a pain in the neck. I might fix it when it breaks and I might add some more processors later. 

**It will fetch the last 1 year of data. You might change `start_time` and `end_time` in `bin/fitbit-graphite` as you like.**

# Get it running

* create an APP on [dev.fitbit.com/apps/new](https://dev.fitbit.com/apps/new)
* `git clone` the project to your disk
* `cd` into the directory
* rename  `.settings.json.example` into `.settings.json` and enter all your credentials and your URL and Port of your graphite instance into that file
* run `bundle install` in the cloned project
* run `bundle exec ruby bin/fitbit-graphite`

