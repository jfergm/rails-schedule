# README

##
##

### Run locally
###### Ruby version ``3.4.2``
###### Setup database ``bin/rails db:migrate``
###### Start server ``.bin/dev``

##
##

#### Tests
###### Run ``EDITOR=nano ./bin/rails credentials:edit``
###### run tests ``rspec``

##
##

### Run with docker
##### Generate the key rails master key
- ###### Delete `config/credentials.yml.enc`
- ###### Run ``EDITOR=nano ./bin/rails credentials:edit``
- ###### Copy generated `/config/master.key` content and paste in `RAILS_MASTER_KEY > compose.yml` or put in the `.env` file with the key `RAILS_MASTER_KEY`
##### Run ``docker compose up -d``
