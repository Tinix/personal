defmodule Personal.Blogs.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blog" do
    field :author, :string
    field :title, :string
    field :dev, :string
    field :content, :string
    field :published_at, :utc_datetime
    field :tags, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:title, :content, :author, :dev, :published_at, :tags])
    |> validate_required([:title, :content, :author, :dev, :published_at, :tags])
  end
end
