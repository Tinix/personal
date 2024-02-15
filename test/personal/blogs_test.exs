defmodule Personal.BlogsTest do
  use Personal.DataCase

  alias Personal.Blogs

  describe "blog" do
    alias Personal.Blogs.Blog

    import Personal.BlogsFixtures

    @invalid_attrs %{
      author: nil,
      title: nil,
      dev: nil,
      content: nil,
      published_at: nil,
      tags: nil
    }

    test "list_blog/0 returns all blog" do
      blog = blog_fixture()
      assert Blogs.list_blog() == [blog]
    end

    test "get_blog!/1 returns the blog with given id" do
      blog = blog_fixture()
      assert Blogs.get_blog!(blog.id) == blog
    end

    test "create_blog/1 with valid data creates a blog" do
      valid_attrs = %{
        author: "some author",
        title: "some title",
        dev: "some dev",
        content: "some content",
        published_at: ~U[2024-02-14 03:26:00Z],
        tags: "some tags"
      }

      assert {:ok, %Blog{} = blog} = Blogs.create_blog(valid_attrs)
      assert blog.author == "some author"
      assert blog.title == "some title"
      assert blog.dev == "some dev"
      assert blog.content == "some content"
      assert blog.published_at == ~U[2024-02-14 03:26:00Z]
      assert blog.tags == "some tags"
    end

    test "create_blog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_blog(@invalid_attrs)
    end

    test "update_blog/2 with valid data updates the blog" do
      blog = blog_fixture()

      update_attrs = %{
        author: "some updated author",
        title: "some updated title",
        dev: "some updated dev",
        content: "some updated content",
        published_at: ~U[2024-02-15 03:26:00Z],
        tags: "some updated tags"
      }

      assert {:ok, %Blog{} = blog} = Blogs.update_blog(blog, update_attrs)
      assert blog.author == "some updated author"
      assert blog.title == "some updated title"
      assert blog.dev == "some updated dev"
      assert blog.content == "some updated content"
      assert blog.published_at == ~U[2024-02-15 03:26:00Z]
      assert blog.tags == "some updated tags"
    end

    test "update_blog/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_blog(blog, @invalid_attrs)
      assert blog == Blogs.get_blog!(blog.id)
    end

    test "delete_blog/1 deletes the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{}} = Blogs.delete_blog(blog)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_blog!(blog.id) end
    end

    test "change_blog/1 returns a blog changeset" do
      blog = blog_fixture()
      assert %Ecto.Changeset{} = Blogs.change_blog(blog)
    end
  end
end
