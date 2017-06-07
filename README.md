# Dummily

Dummily is a sample of REST API with Maru.

## Resources
### Users
- user_name
- email
- posts

### Posts
- title
- body
- date

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add `dummily` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:dummily, "~> 0.1.0"}]
end
```

2. Ensure `dummily` is started before your application:

```elixir
def application do
  [applications: [:dummily]]
end
```

## Testing

```sh
$ iex -S mix
$ curl "http://localhost:8880/users"
$ curl "http://localhost:8880/users/1"
$ curl "http://localhost:8880/users?username=john"
```