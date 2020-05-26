defmodule DocFlowTest do
  use ExUnit.Case
  doctest DocFlow

  test "greets the world" do
    assert DocFlow.hello() == :world
  end
end
