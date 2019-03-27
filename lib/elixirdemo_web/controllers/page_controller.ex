defmodule ElixirdemoWeb.PageController do
  @moduledoc """
  This module generally handles all requests related to the page
  """

  use ElixirdemoWeb, :controller

  @doc """
  This method will accept the connection and given params,
  call the sum method of n natural numbers
  and will display on the web page
  """
  def index(conn, params) do
    contents = sum(params["num"] |> convert_to_int())
    render conn, "index.html", contents: contents, num: params["num"]
  end

  @doc """
  This method works in the tail recursion manner
  accumulator will get added to the number and each iteration we'll reduce the number
  once number is equal to zero we will return the accumulator back.
  simple tail recursion is being used here
  """
  def sum(num), do: sum(0, num)
  def sum(acc, 0), do: acc
  def sum(acc, num), do: sum(acc + num, num - 1)

  @doc """
  This method converts to integer
  accepted types are decimal, string, float
  """
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
