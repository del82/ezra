Ezra on rails.

Set up:

1. Install [RVM](https://rvm.io/)
2. Install ruby 1.9.3: `$ rvm install 1.9.3`
3. restart the shell
4. `$ git clone git@github.com:del82/ezra.git`
5. `$ bundle install`
5. Consider generating a new secret token in `config/initializers/secret_token.rb`.  Until you do, the application is completely insecure.
6. initialize the db:
   `$ rake db:migrate`
   `$ rake db:populate`
   `$ rake db:test:prepare`
6. run the tests:
   `$ rspec`
7. If you like, start guard/spork to detect code changes and run tests automatically.
`$ guard`
8. Hack away


