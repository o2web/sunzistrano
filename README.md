# Sunzistrano

TODO: Basic deploy scenario with Capistrano and Sunzi already configured.

TODO: describe the scenario

## Installation

Add this line to your application's Gemfile:

`gem 'sunzistrano', github: 'o2web/sunzistrano', branch: 'master', group: [:development]`

Install [Sunzi](https://github.com/kenn/sunzi) if not already installed:

    $ gem install sunzi

And then execute:

    $ bundle

    $ bundle exec rails g sunzistrano:install

Find all the todos added and change the configurations to your needs.

If this is not a new rails project, diff your project after running the install and bring back what is needed.

Also, your ruby and passenger versions are in `config/sunzi/sunzi.yml`

## Usage

    $ cd config/sunzi

    $ sunzi deploy admin@todo.todo.todo.todo admin --sudo

    $ sunzi deploy deploy@todo.todo.todo.todo deploy

    $ cd ../..

    $ bundle exec cap staging deploy

    $ bundle exec cap staging db:local_to_server

    $ bundle exec cap staging nginx:export_conf

    $ bundle exec cap staging nginx:restart

Optional:

    $ # upload pictures, attachments

You're done!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sunzistrano/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
