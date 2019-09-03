[![Code Climate](https://codeclimate.com/github/nebulab/simple_command/badges/gpa.svg)](https://codeclimate.com/github/nebulab/simple_command)
[ ![Codeship Status for nebulab/simple_command](https://app.codeship.com/projects/45ce7790-8daf-0132-1412-669677a474c3/status?branch=master)](https://app.codeship.com/projects/60741)

# SimpleCommand

A simple, standardized way to build and use _Service Objects_ (aka _Commands_) in Ruby

## Requirements

* Ruby 2.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_command'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_command

## Usage

Here's a basic example of a command that authenticates a user

```ruby
# define a command class
class AuthenticateUser
  # put SimpleCommand before the class' ancestors chain
  prepend SimpleCommand
  include ActiveModel::Validations

  # optional, initialize the command with some arguments
  def initialize(email, password)
    @email = email
    @password = password
  end

  # mandatory: define a #call method. its return value will be available
  #            through #result
  def call
    if user = User.find_by(email: @email)&.authenticate(@password)
      return user
    else
      errors.add(:base, :failure)
    end
    nil
  end
end
```

in your locale file
```yaml
# config/locales/en.yml
en:
  activemodel:
    errors:
      models:
        authenticate_user:
          failure: Wrong email or password
```

Then, in your controller:

```ruby
class SessionsController < ApplicationController
  def create
    # initialize and execute the command
    # NOTE: `.call` is a shortcut for `.new(args).call`
    command = AuthenticateUser.call(session_params[:email], session_params[:password])

    # check command outcome
    if command.success?
      # command#result will contain the user instance, if found
      session[:user_token] = command.result.secret_token
      redirect_to root_path
    else
      flash.now[:alert] = t(command.errors.full_messages.to_sentence)
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
```

## Test with Rspec
Make the spec file `spec/commands/authenticate_user_spec.rb` like:

```ruby
describe AuthenticateUser do
  subject(:context) { described_class.call(username, password) }

  describe '.call' do
    context 'when the context is successful' do
      let(:username) { 'correct_user' }
      let(:password) { 'correct_password' }
      
      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(:username) { 'wrong_user' }
      let(:password) { 'wrong_password' }

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end
```

## Contributing

1. Fork it ( https://github.com/nebulab/simple_command/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
