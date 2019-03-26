defmodule ElixirdemoWeb.PageController do
  use ElixirdemoWeb, :controller

  def index(conn, params) do
    contents = sum(params["num"] |> convert_to_int())
    render conn, "index.html", contents: contents, num: params["num"]
  end

  def sum(num), do: sum(0, num)
  def sum(acc, 0), do: acc
  def sum(acc, num), do: sum(acc + num, num - 1)


  def convert_to_int(value) do
    case is_binary(value) do
      false ->
        case is_float(value) do
          false ->
            case Decimal.decimal?(value) do
              true -> value |> Decimal.round() |> Decimal.to_integer()
              _ -> value
            end

          _ ->
            Kernel.trunc(value)
        end

      _ ->
        {usr, _} = Integer.parse(value)
        usr
    end
  end
end
