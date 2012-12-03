# Jruby Mahout
Jruby Mahout is a gem that unleashes the power of Apache Mahout in the world of Jruby.

## Quick Overview
Apache Mahout is a machine learning library developed for Java.

## Get Mahout
First of all you need to download Mahout library from one of the [mirrors](http://www.apache.org/dyn/closer.cgi/mahout/). Jruby Mahout only supports Mahout 0.7 at this point.

## Installation
### 1. Set environment variable MAHOUT_DIR to point at your Mahout installation.
### 2. Add the gem to your `Gemfile`
```ruby
platform :jruby do
  gem "jruby_mahout"
end
```
And run `bundle install`.

## Contribute
Fork the repo, do work, test it, pull request.