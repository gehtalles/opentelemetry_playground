defmodule OpenTelemetryPlaygroundTest do
  use ExUnit.Case
  doctest OpenTelemetryPlayground

  test "greets the world" do
    assert OpenTelemetryPlayground.hello() == :world
  end
end
