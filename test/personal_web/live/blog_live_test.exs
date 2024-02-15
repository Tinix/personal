defmodule PersonalWeb.BlogLiveTest do
  use PersonalWeb.ConnCase

  import Phoenix.LiveViewTest
  import Personal.BlogsFixtures

  @create_attrs %{author: "some author", title: "some title", dev: "some dev", content: "some content", published_at: "2024-02-14T03:26:00Z", tags: "some tags"}
  @update_attrs %{author: "some updated author", title: "some updated title", dev: "some updated dev", content: "some updated content", published_at: "2024-02-15T03:26:00Z", tags: "some updated tags"}
  @invalid_attrs %{author: nil, title: nil, dev: nil, content: nil, published_at: nil, tags: nil}

  defp create_blog(_) do
    blog = blog_fixture()
    %{blog: blog}
  end

  describe "Index" do
    setup [:create_blog]

    test "lists all blog", %{conn: conn, blog: blog} do
      {:ok, _index_live, html} = live(conn, ~p"/blog")

      assert html =~ "Listing Blog"
      assert html =~ blog.author
    end

    test "saves new blog", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/blog")

      assert index_live |> element("a", "New Blog") |> render_click() =~
               "New Blog"

      assert_patch(index_live, ~p"/blog/new")

      assert index_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#blog-form", blog: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/blog")

      html = render(index_live)
      assert html =~ "Blog created successfully"
      assert html =~ "some author"
    end

    test "updates blog in listing", %{conn: conn, blog: blog} do
      {:ok, index_live, _html} = live(conn, ~p"/blog")

      assert index_live |> element("#blog-#{blog.id} a", "Edit") |> render_click() =~
               "Edit Blog"

      assert_patch(index_live, ~p"/blog/#{blog}/edit")

      assert index_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#blog-form", blog: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/blog")

      html = render(index_live)
      assert html =~ "Blog updated successfully"
      assert html =~ "some updated author"
    end

    test "deletes blog in listing", %{conn: conn, blog: blog} do
      {:ok, index_live, _html} = live(conn, ~p"/blog")

      assert index_live |> element("#blog-#{blog.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#blog-#{blog.id}")
    end
  end

  describe "Show" do
    setup [:create_blog]

    test "displays blog", %{conn: conn, blog: blog} do
      {:ok, _show_live, html} = live(conn, ~p"/blog/#{blog}")

      assert html =~ "Show Blog"
      assert html =~ blog.author
    end

    test "updates blog within modal", %{conn: conn, blog: blog} do
      {:ok, show_live, _html} = live(conn, ~p"/blog/#{blog}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Blog"

      assert_patch(show_live, ~p"/blog/#{blog}/show/edit")

      assert show_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#blog-form", blog: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/blog/#{blog}")

      html = render(show_live)
      assert html =~ "Blog updated successfully"
      assert html =~ "some updated author"
    end
  end
end
