# README

* Ruby version 2.5.0
* Rails version 6.1.1
* Docker Compose version 1.26.0, build d4451659

### How to run the test suite
docker-compose run --rm -e RAILS_ENV=test rails rspec

### How to run project
docker-compose build; docker-compose up

### How to use

### create user
```bash
curl --request POST \
  --url http://localhost:3000/users \
  --header 'content-type: application/json' \
  --data '
{"username": "ximbinha", "password": "12345678"}'
```

### create account
```bash
curl --request POST \
  --url http://localhost:3000/accounts \
  --header 'authorization:: Bearer <TOKEN>' \
  --header 'content-type: application/json' \
  --data '{ "account_name": "City Badnk", "user_id": 2
}'
```
### transfer
```bash
curl --request POST \
  --url http://localhost:3000/accounts/transfer \
  --header 'authorization:: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.StJRwcLkX2RrHUtmr-JP3CzXmjQGDfIgZzkkqbbgPVY' \
  --header 'content-type: application/json' \
  --data '{"source_account_id": 1, "destination_account_id": 2, "amount":50}'
```
### get account balance
```bash
curl --request GET \
  --url http://localhost:3000/balance/1612056609 \
  --header 'authorization:: Bearer <TOKEN>' \
  --header 'content-type: application/json' \
```

### token
```bash
curl --request POST \
  --url http://localhost:3000/tokens \
  --header 'content-type: application/json' \
  --data '
{"username": "userd2d", "password": "12345678"}'
```