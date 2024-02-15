defmodule Personal.Repo.Migrations.CreateBlog do
  use Ecto.Migration

  def change do
    create table(:blog) do
      add :title, :string
      add :content, :string
      add :author, :string
      add :dev, :string
      add :published_at, :utc_datetime
      add :tags, :string

      timestamps(type: :utc_datetime)
    end
  end
end
