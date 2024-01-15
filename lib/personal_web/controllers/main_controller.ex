defmodule PersonalWeb.MainController do
  use PersonalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
