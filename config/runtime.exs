import Config

honeycomb_api_key =
  System.get_env("HONEYCOMB_API_KEY") ||
    raise """
    environment variable HONEYCOMB_API_KEY is missing.
    """

config :opentelemetry, :processors,
  otel_batch_processor: %{
    exporter:
      {:opentelemetry_exporter,
       %{
         protocol: :grpc,
         headers: [
           {'x-honeycomb-team', honeycomb_api_key},
           {'x-honeycomb-dataset', 'opentelemetry_playground'}
         ],
         endpoints: [{:https, 'api.honeycomb.io', 443, []}]
       }}
  }
