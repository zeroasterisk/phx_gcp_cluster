defmodule PhxGcpClusterWeb.PageController do
  use PhxGcpClusterWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
