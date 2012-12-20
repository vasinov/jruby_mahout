# Jruby Mahout
Jruby Mahout is a gem that unleashes the power of Apache Mahout in the world of Jruby. Mahout is a superior machine learning library written in Java. It deals with recommendations, clustering and classification machine learning problems at scale. Until now it was difficult to use it in Ruby projects. You'd have to implement Java interfaces in Jruby yourself, which is not quick especially if you just started exploring the world of machine learning.

The goal of this library is to make machine learning at scale in Jruby projects simple.

## Quick Overview
This is an early version of a Jruby gem that only supports Mahout recommendations. It also includes a simple Postgres manager that can be used to manage appropriate recommendations tables. Unfortunately it's impossible to use ActiveRecord (AR) with Mahout, because AR at a mach higher level and creates a lot of overhead that is critical when dealing with millions of records in real time.

## Get Mahout
First of all you need to download Mahout library from one of the [mirrors](http://www.apache.org/dyn/closer.cgi/mahout/). Jruby Mahout only supports Mahout 0.7 at this point.

## Get Postgres JDBC Adapter
If you wish to work with a database for recommendations, you'll have to install [JDBC 4 driver for Postgres 9.0 and higher](http://jdbc.postgresql.org/download.html). Another option is to use file-based recommendation.

## Installation
### 1. Set environment variable MAHOUT_DIR to point at your Mahout installation.
### 2. Add the gem to your `Gemfile`
```ruby
platform :jruby do
  gem "jruby_mahout"
end
```
And run `bundle install`.

## How to Use?
I am planning to add more examples covering Jruby Mahout use cases to [this repo](https://github.com/vasinov/jruby_mahout-examples) soon.

The easiest way to start working with Jruby Mahout recommendations is to initialize a recommender:
```ruby
require 'jruby_mahout'
recommender = JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", 5, "GenericUserBasedRecommender", false)
```

Setup a data model:
```ruby
recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "recommender_data.csv" }).data_model
```

and get recommendations:
```ruby
puts recommender.recommend(2, 10, nil) # 10 recommendations for user with id = 2
```

You can evaluate your recommender to see how efficient it is:
```ruby
puts recommender.evaluate(0.7, 0.3)
```

The closer the score is to zero—the better.

I realize that it's a very sparse introduction into Jruby Mahout. I am working on the tutorial and better documentation that should cover this gem more in depth. Stay tuned at [my blog](http://www.vasinov.com/blog).

## Development Plans
There are several things that should be supported by this gem, before it can be used in production. Some of them are:
- Hadoop integration
- Clustering support
- Classification support
- Better docs

If you feel like you can help—please do.

## Testing
Jruby Mahout is thoroughly tested with Rspec.

## Contribute
- Fork the project.
- Write code for a feature or bug fix.
- Add Rspec tests for it.
- Commit, do not make changes to rakefile or version.
- Submit a pull request.