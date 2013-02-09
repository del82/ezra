Ezra on rails.

Set up:

1. Install [RVM](https://rvm.io/)
2. Install ruby 1.9.3: `$ rvm install 1.9.3`
3. restart the shell
4. `$ git clone git@github.com:del82/ezra.git`
5. `$ bundle install`
6. **Important** create a secret token
   * For development, you can just copy the `config/initializers/secret_token_template.rb` file to `config/initializers/secret_token.rb` and uncomment the last line.
   * Better is to do something like this:
     ``cat config/initializers/secret_token_template.rb | sed s/you_should_replace_me_with_secret_token/`rake secret`/ > config/initializers/secret_token.rb`` and uncomment the last line.
7. run the tests:
   `$ rspec`
8. If you like, start guard/spork to detect code changes and run tests automatically.
`$ guard`
9. Hack away


