# Automation Health Status

Welcome to your new Automation Health application. This README serves as a starting point.

## Requirements

In order to run this application you'll need to have Ruby installed on your computer.Optionally you can install Bundler and use it for Gem management, this
can be done as following:

    $ gem install bundler
    $ bundle install

## Rake Tasks

This application comes with a few predefined Rake tasks that make it easy to
get started. You can list these tasks by running `rake -T` or `rake -D` (this
shows longer descriptions for tasks if there are any).

For example, to start a Ramaze console using Pry you'd run the following
command:

    $ rake ramaze:start
    $ rake ramaze:pry