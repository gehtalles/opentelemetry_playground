defmodule OpenTelemetryPlayground.Worker do
  use GenServer

  require Logger
  require OpenTelemetry.Tracer, as: Tracer

  alias OpenTelemetry.Span

  @impl true
  def init(stack) do
    OpenTelemetry.Tracer.with_span "init" do
      Logger.info("Starting #{__MODULE__}...")
      {:ok, stack}
    end
  end

  def push(pid \\ __MODULE__, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid \\ __MODULE__) do
    GenServer.call(pid, :pop)
  end

  def start_link(_opts) do
    Tracer.with_span "start_link" do
      span_ctx = Tracer.current_span_ctx()
      Span.set_attribute(span_ctx, "hello", "world")
      GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
