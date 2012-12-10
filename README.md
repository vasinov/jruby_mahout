# Jruby Mahout
Jruby Mahout is a gem that unleashes the power of Apache Mahout in the world of Jruby. Mahout is a superior machine learning library written in Java. It deals with recommendations, clustering and classification machine learning problems at scale. Until now it was difficult to use it in Ruby projects. You'd have to implement Java interfaces in Jruby yourself, which is not quick especially if you just started exploring the world of machine learning.

The goal of this library is to make machine learning at scale in Jruby projects simple.

## Quick Overview
This is an early version of a Jruby gem that only supports Mahout recommendations. It also includes a simple Postgres manager that can be used to manage appropriate recommendations tables. Unfortunately it's impossible to use ActiveRecord (AR) with Mahout, because AR at a mach higher level and creates a lot of overhead that is critical when dealing with millions of records in real time.

## Get Mahout
First of all you need to download Mahout library from one of the [mirrors](http://www.apache.org/dyn/closer.cgi/mahout/). Jruby Mahout only supports Mahout 0.7 at this point.

## Get Postgres JDBC Adapter
If you wish to work with a database for recommendations, you'll have to install [JDBC driver for Postgres](http://jdbc.postgresql.org/download.html). Another option is to use file-based recommendation.

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
- Fork the project.
- Write code for a feature or bug fix.
- Add Rspec tests for it.
- Commit, do not make changes to rakefile or version.
- Submit a pull request.