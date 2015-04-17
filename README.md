# Ocioso

Micro Library for initialize objects

## Installation

Installing Ocioso is as simple as running:

```
$ gem install ocioso
```

Include Ocioso in your Gemfile with gem 'ocioso' or require it with require 'ocioso'.

Usage
-----

You can automatically instance variables without write an initialize method, just send a hash with your name variables and its values when you instantiate a class.

```ruby
class User
  include Ocioso
end

user = User.new name: "Julio", email: "julio@email.com"

# This is the same thing of do:
# class User
#   def initialize(name, email)
#     @name = name
#     @email = email
#   end
# end

puts user.inspect
#<User @name = "Julio", @email = "julio@email.com">
```

If you define your writer methods you can initialize your variables using a block:

```ruby
User.new do |user|
  user.name = "Julio"
  user.email = "julio@email.com"
end
```

## Allow certain Values

If you want to only allow some certain variables, you can use `initialize_only_with` method. Other sent variables that haven't been specified won't be initializated.

```ruby
class User
  include Ocioso
  initialize_only_with :name
end

user = User.new name: "Julio", age: 25
puts user.inspect
#<User @name = "Julio">
```

## Default Values

You can define your default values for your instance variables using the `initialize_defaults` method.

```ruby
class User
  include Ocioso
  initialize_defaults name: "Julio", email: "my_email@email.com"
end

# This is the same thing of do:
# class User
#   def initialize(name = "Julio", email = "my_email@email.com")
#     @name = name
#     @email = email
#   end
# end

user = User.new
puts user.inspect
#<User @name = "Julio", @email = "my_email@email.com">

other_user = User.new name: "Piero"
puts other_user.inspect
#<User @name = "Piero", @email = "my_email@email.com">
```

## Open to Initialize

You can still use your initialize method to do whatever you need, just not forget to send the `super method to handle the initialize of Ocioso.

```ruby
class User
  include Ocioso
  def initialize(*args)
    super(*args)
    #doing whatever
  end
end
```