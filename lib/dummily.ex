defmodule Dummily do
end

defmodule Dummily.Router.Users do
  use Maru.Router

  def all_users do
    [
      %{
        id: 1,
        username: "john",
        email: "john@example.com",
        posts: 1
      },
      %{
        id: 2,
        username: "meg",
        email: "meg@example.com",
        posts: 3
      },
      %{
        id: 3,
        username: "kurt",
        email: "kurt@example.com",
        posts: 0
      }
    ]
  end

  def matchs?(value, pattern) do
    case pattern do
      p when is_nil(p) -> true
      p when is_binary(p) -> String.contains? value, p
      p when is_number(p) -> p == value
      _ -> false
    end
  end

  def filter(resources, pattern) do
    Enum.filter(resources, fn(r) ->
      Enum.all?(r, fn({k, v}) -> matchs?(v, pattern[k]) end)
    end)
  end

  def sort_by(resources, sorter) do
    Enum.sort(resources, &(&1[sorter] <= &2[sorter]))
  end

  namespace :users do
    version "v1" do
      params do
        optional :username, type: String
        optional :email, type: String
        optional :posts, type: Integer
        optional :sort, type: Atom, values: [:username, :id, :posts], default: :id
      end
      get do
        users = all_users() |> filter(params) |> sort_by(params[:sort])
        conn |> put_status(200) |> json(users)
      end

      route_param :id, type: Integer do
        get do
          users = all_users() |> filter(params)
          conn |> put_status(200) |> json(users)
        end
      end

    end
  end
end

defmodule Dummily.API do
  use Maru.Router

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]
  
  mount Dummily.Router.Users

  rescue_from :all do
    conn
    |> put_status(500)
    |> text("Server Error")
  end
end
