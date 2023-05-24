# Sydecar

This is a ruby gem for Sydecar API https://api-docs.sydecar.io/

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sydecar

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sydecar

## Usage

### Supported endpoints:
1. Person: create, find, update, find_all, kyc
2. Entity: create, find, update, find_all
3. Bank Account: create, find, update, find_all, delete
4. SPV: all
5. Vendor: create, find, update, find_all
6. Expense: create, find, update, find_all, delete, pay, cancel
7. Subscription: all
8. Documents: all

### Example usage:
* Finding a Person: `Sydecar::Person.find(id: person_id)`
* Creating a Bank Account: `Sydecar::BankAccount.create(body: body)`
* Updating an entity: `Sydecar::Entity.update(id: entity_id, body: {})`

## Development

After checking out the repo, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Play-Money/sydecar.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
