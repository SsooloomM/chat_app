# TODO
## Initialize Git Repository: (20 min) (10 min)
- [X] Create a GitHub repository for the project.

## Initialize PostgreSQL Database: (30 min) (30 min)
- [X] Design the database schema for the application.
- [X] Create a `docker-compose.yml` file with a PostgreSQL service.

## Set Up Rails API Application (1 day): 
- [X] Initialize the Rails application using a template. (1 hour)
- [X] Integrate the app with the PostgreSQL database. (20 min)
- [ ] Create models and RESTful APIs (5 hours):
  - [ ] Define core models for the application (App, Chat, Message).  (2 hours)
  - [ ] Add RSpec tests for models. (1 hour)
  - [ ] Implement controllers (1 hour)
  - [ ] Implement corresponding RSpec tests. (2 hours)

## Set Up Docker for the Rails Application (4 hours):
- [ ] Create a `Dockerfile` for the Rails app (2 hours):
  - [ ] Define the Ruby image and install required dependencies.
  - [ ] Copy the application code into the container.
  - [ ] Set up the Rails server command.
- [ ] Add Rails service to `docker-compose.yml` (1 hour):
  - [ ] Define the Rails app service with environment variables.
  - [ ] Link the Rails app service with the PostgreSQL and Redis services.
- [ ] Build and run the Rails app in Docker. (1 hour -- expect problems --)

## Implement Record Counting (2 hour):
- [ ] Add Sidekiq and Redis to `docker-compose.yml`. (1 hour)
- [ ] Configure background jobs in the Rails app using Sidekiq. (20 min)
- [ ] Create jobs to count records in the application and store the results. (20 min)

## Implement Caching (1 hour):
- [ ] Use Redis to cache record counts instead of querying the database directly.

## Integrate Elasticsearch for Search (4 hours):
- [ ] Add an Elasticsearch service to `docker-compose.yml`. (1.5 hours)
- [ ] Integrate the Rails app with Elasticsearch.
- [ ] Save messages in Elasticsearch. (1 hour)
- [ ] Implement search functionality using Elasticsearch instead of PostgreSQL. (1 hour) 

## Add Queueing System (3 hours):
- [ ] Add a RabbitMQ service to `docker-compose.yml`. (30 min)
- [ ] Update the application to push messages to queues instead of writing directly to the database. ( 2 hours )

## Implement Consumers (3 hours):
- [ ] Create consumers to process messages from RabbitMQ queues. (2 hours)
- [ ] Ensure consumers save messages to both Elasticsearch and PostgreSQL. ( 1 hour)
