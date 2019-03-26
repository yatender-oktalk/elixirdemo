defmodule ElixirDemoWeb.ContentModel do

  def calculate_sum(num) do
    sum(0, num)
  end

  def sum(num), do: sum(0, num)
  def sum(acc, 0), do: acc
  def sum(acc, num), do: sum(acc + num, num - 1)

end