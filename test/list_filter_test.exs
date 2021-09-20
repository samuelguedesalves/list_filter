defmodule ListFilterTest do
  use ExUnit.Case

  describe "call/1" do
    test "count number odd of a list" do
      list = ["1", "3", "6", "43", "banana", "6", "abc", 9]

      assert ListFilter.call(list) == 4
    end
  end
end
