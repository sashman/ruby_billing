# RubyBilling

## Usage

Install dependencies:

```
bundle
```

Run tests with:

```
rspec
```

Example output:

```
RubyBilling::Checkout
  .total
    with promotion combination
      Basket: 001,002,003 Total: £66.78
      Basket: 001,003,001 Total: £36.95
      Basket: 001,002,001,003 Total: £73.76

RubyBilling::Checkout
  .total
    without promotions
      returns 0 for no items
      returns total price for multiple items
    with total threshold promotion
      returns 0 for no items
      returns normal price for not over 100 total
      returns half price for over 100 total
    with item list based promotion
      returns 0 for no items
      returns normal price for not over 3 001 items
      returns half price 001s for over 3 of them in the list

RubyBilling
  has a version number

Finished in 0.0037 seconds (files took 0.18813 seconds to load)
12 examples, 0 failures

```

## Dockerized example

```
docker build -t ruby_billing . &&  docker run ruby_billing
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_billing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_billing
