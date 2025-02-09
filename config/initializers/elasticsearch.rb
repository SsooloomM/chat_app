require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: ENV["ELASTICSEARCH_HOST"],
  port: ENV["ELASTICSEARCH_PORT"],
  retry_on_failure: true,
  log: true
)