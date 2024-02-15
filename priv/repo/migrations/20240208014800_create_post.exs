defmodule Personal.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :title, :string
      add :content, :text
      add :image, :string

      timestamps(type: :utc_datetime)
    end
  end
end
