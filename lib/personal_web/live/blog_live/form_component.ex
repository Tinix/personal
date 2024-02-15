defmodule PersonalWeb.BlogLive.FormComponent do
  use PersonalWeb, :live_component

  alias Personal.Blogs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage blog records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="blog-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:content]} type="text" label="Content" />
        <.input field={@form[:author]} type="text" label="Author" />
        <.input field={@form[:dev]} type="text" label="Dev" />
        <.input field={@form[:published_at]} type="datetime-local" label="Published at" />
        <.input field={@form[:tags]} type="text" label="Tags" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Blog</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{blog: blog} = assigns, socket) do
    changeset = Blogs.change_blog(blog)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"blog" => blog_params}, socket) do
    changeset =
      socket.assigns.blog
      |> Blogs.change_blog(blog_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"blog" => blog_params}, socket) do
    save_blog(socket, socket.assigns.action, blog_params)
  end

  defp save_blog(socket, :edit, blog_params) do
    case Blogs.update_blog(socket.assigns.blog, blog_params) do
      {:ok, blog} ->
        notify_parent({:saved, blog})

        {:noreply,
         socket
         |> put_flash(:info, "Blog updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_blog(socket, :new, blog_params) do
    case Blogs.create_blog(blog_params) do
      {:ok, blog} ->
        notify_parent({:saved, blog})

        {:noreply,
         socket
         |> put_flash(:info, "Blog created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
