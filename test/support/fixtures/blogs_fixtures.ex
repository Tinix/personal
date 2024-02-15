defmodule Personal.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Personal.Blogs` context.
  """

  @doc """
  Generate a blog.
  """
  def blog_fixture(attrs \\ %{}) do
    {:ok, blog} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content",
        dev: "some dev",
        published_at: ~U[2024-02-14 03:26:00Z],
        tags: "some tags",
        title: "some title"
      })
      |> Personal.Blogs.create_blog()

    blog
  end
end
