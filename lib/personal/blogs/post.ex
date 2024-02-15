defmodule Personal.Blogs.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :title, :string
    field :image, :string
    field :content, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :image])
    |> validate_required([:title, :content, :image])
  end
end
