defmodule Personal.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Personal.Blogs` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        image: "some image",
        title: "some title"
      })
      |> Personal.Blogs.create_post()

    post
  end
end
