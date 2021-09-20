defmodule ListFilter do
  def call(list), do: filter(list)

  defp filter(list) do
    filtered_list =
      Enum.filter(list, fn item ->
        item
        |> parse_to_integer()
        |> case do
          {:ok, _number} -> true
          {:error, _reason} -> false
        end
      end)

    parsed_list =
      Enum.map(filtered_list, fn value ->
        case is_bitstring(value) do
          true -> String.to_integer(value)
          false -> value
        end
      end)

    odd_list =
      Enum.filter(parsed_list, fn item ->
        (item / 2)
        |> Float.to_string()
        |> String.split(".")
        |> Enum.at(1)
        |> case do
          "0" -> false
          _ -> true
        end
      end)

    Enum.reduce(odd_list, 0, fn _, acc -> acc + 1 end)
  end

  defp parse_to_integer(item) when is_bitstring(item) do
    try do
      parsed_item = String.to_integer(item)
      {:ok, parsed_item}
    rescue
      _ -> {:error, "item don't match with number type"}
    end
  end

  defp parse_to_integer(item) when is_integer(item), do: {:ok, item}
end
