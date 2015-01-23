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

  # optional, initialize the command with some arguments
  def initialize(user, password)
    @user = user
    @password = password
  end

  # mandatory: define a #call method. its return value will be available
  #            through #result
  def call
    if user = User.authenticate(@email, @password)
      return user
    else
      errors.add(authentication: I18n.t "authenticate_user.failure")
    end
    nil
  end
end
```

Then, in your controller:

```ruby
class SessionsController < ApplicationController
  def create
    # initialize and execute the command
    # NOTE: `.call` is a shortcut for `.new(args).call)`
    command = AuthenticateUser.call(session_params[:user], session_params[:password])

    # check command outcome
    if command.success?
      # command#result will contain the user instance, if found
      session[:user_token] = command.result.secret_token
      redirect_to root_path
    else
      flash.now[:alert] = t(command.errors[:authentication])
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
```

## Contributing

1. Fork it ( https://github.com/nebulab/simple_command/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
