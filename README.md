# Dummily

Dummily is a sample of REST API with Maru.

## Resources
### Users
- user_name
- email
- posts

## Installation

```sh
$ git clone git@github.com:kohei-kimura/dummily.git
$ cd dummily
$ mix deps.get
```

## Testing

```sh
$ iex -S mix
$ curl "http://localhost:8880/users"
$ curl "http://localhost:8880/users/1"
$ curl "http://localhost:8880/users?username=john"
```