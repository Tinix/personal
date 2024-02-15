defmodule PersonalWeb.BlogLive.Index do
  use PersonalWeb, :live_view

  alias Personal.Blogs
  alias Personal.Blogs.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :blog_collection, Blogs.list_blog())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Blog")
    |> assign(:blog, Blogs.get_blog!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Blog")
    |> assign(:blog, %Blog{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Blog")
    |> assign(:blog, nil)
  end

  @impl true
  def handle_info({PersonalWeb.BlogLive.FormComponent, {:saved, blog}}, socket) do
    {:noreply, stream_insert(socket, :blog_collection, blog)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    blog = Blogs.get_blog!(id)
    {:ok, _} = Blogs.delete_blog(blog)

    {:noreply, stream_delete(socket, :blog_collection, blog)}
  end
end
