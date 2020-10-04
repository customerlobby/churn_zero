# ChurnZero

A Ruby wrapper for the Churn Zero HTTP API.

## Installation

Add this line to your application's Gemfile:

    gem 'churn_zero'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install churn_zero

## Usage

### Configuration

Before you can make calls to ChurnZero you must configure the library with a valid Application Key. You can create as
many application keys from ChurnZero Admin section.

There are two ways to configure the ChurnZero gem. You can pass a hash of configuration options when you create
a client, or you can use a configure block.

```ruby
client = ChurnZero.client({app_key: "YOUR_KEY_HERE"})
```

```ruby
ChurnZero.configure do |config|
  config.app_key = "YOUR_KEY_HERE"
end

client = ChurnZero.client
```

### Resources

There are currently three Churn Zero APIs implemented in this client; trackEvents, setAttribute and incrementAttribute.
See the parameters section below for information about what kinds of parameters can be sent in each of them.

Tracking Events(single event)

```ruby
params = { account_external_id: 2, contact_external_id: 1, event_name: 'Transaction Count', quantity: 25 }
client.track(params)
```

To Track multiple events in a single API call:

```ruby
params = [{account_external_id: 2, contact_external_id: 1, event_name: 'Transaction Count', quantity: 25},
          {account_external_id: 2, contact_external_id: 1, event_name: 'Non Zero Transaction Count', quantity: 5},
          {account_external_id: 2, contact_external_id: 1, event_name: 'Prospects Transaction Count', quantity: 8}]
client.track(params)
```

Setting Attribute(single attribute)

```ruby
params = { account_external_id: 2, contact_external_id: 1, entity: 'contact', name: 'attr_1', value: '23' }
client.write(params)
```

To set multiple attributes in a single call:

```ruby
params = [{account_external_id: 2, contact_external_id: 1, entity: 'contact', name: 'attr_1', value: '23'},
          {account_external_id: 2, contact_external_id: 1, entity: 'contact', name: 'attr_2', value: '24'},
          {account_external_id: 2, contact_external_id: 1, entity: 'contact', name: 'attr_3', value: '25'}]
client.write(params)
```

Increment Attribute:

```ruby
params = { account_external_id: 2, contact_external_id: 1, entity: 'contact', name: 'attr_1', value: '23' }
client.increment(params)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
