# Sydecar

This is a ruby gem for Sydecar API https://api-docs.sydecar.io/

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sydecar

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sydecar

### Supported endpoints:
1. Person: create, find, update, find_all, kyc
2. Entity: create, find, update, find_all
3. Profile: find, activate_spv, deactivate_spv, find_all, accreditation_qualification_opts
4. Bank Account: create, find, update, find_all, delete
5. Vendor: create, find, update, find_all
6. Expense: create, find, update, find_all, delete, pay, cancel
7. SPV: create, find, update, find_all, initiate_close, disburse_close, counter_sign_close, request_approval, request_bank_account, disbursements, adjust_disbursements, adjust_fund_deal_investments
8. Subscription: create, funding_countries_list, find, update, delete, create_agreement_preview, create_virtual_bank_account, set_balance, sign, amend, send_ach_with_plaid, refund_ach_with_plaid, refund, find_all
9. Document: find, delete, preview, sign, required_fields, sign_arbitrary, find_all, download, upload

### Example usage:
1. Create a Person: 
```
body = {...} # put your data here
person = Sydecar::Person.create(body: body, idempotency_key: 'unique')
```
2. Create an Entity: 
```
entity_body = {...} # put your data here
entity = Sydecar::Entity.create(body: entity_body)
```
3. Create an Entity Profile:
```
entity_profile_body = {...} # put your data here
entity_profile_body['person_id'] = person.body['id'] 
profile = Sydecar::Profile::Entity.create(body: entity_profile_body)
```
4. Create Bank Account:
```
bank_account_body['profile_ids'] = [profile.body['id']]
bank = Sydecar::BankAccount.create(body: bank_account_body, idempotency_key: 'unique')
```
5. Create SPV:
```
spv_body = {...}
spv_body['spv_lead_profile_id'] = profile.body['id']
spv = Sydecar::Spv.create(body: spv_body, idempotency_key: 'unique')
```
6. Create a Vendor:
```
vendor_body = {...}
vendor = Sydecar::Vendor(body: vendor_body)
```
7. Create Expense:
```
expense_body = {...}
expense_body['spv_id'] = spv.body['id']
expense_body['vendor_id'] = vendor.body['id']
expense = Sydecar::Expense.create(body: expense_body)
```
8. Create a Subscription:
```
sub_body = {...}
sub_body['spv_id'] = spv.body['id']
sub_body['subscriptions'][0]['profile_id'] = profile.body['id']
subscription = Sydecar::Subscription.create(body: sub_body, idempotency_key: 'unique')
```
9. Upload a Document:
```
doc_boby = {
  type: 'DRAFT_INVESTMENT',
  name: 'file_name', # Faraday expects here just name without extension
  profile_id: profile.body['id'], # it's possible to set only 1 id from the following list
  spv_id: spv.body['id'],
  subscription_id: subscription.body['id'],
  expense_id: expense.body['id']
}

doc = Sydecar::Document.upload(body: doc_body, idempotency_key: 'unique')
```

## Development

After checking out the repo, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Play-Money/sydecar.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
