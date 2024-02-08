defmodule PersonalWeb.PostControllerTest do
  use PersonalWeb.ConnCase

  import Personal.BlogsFixtures

  @create_attrs %{title: "some title", image: "some image", content: "some content"}
  @update_attrs %{title: "some updated title", image: "some updated image", content: "some updated content"}
  @invalid_attrs %{title: nil, image: nil, content: nil}

  describe "index" do
    test "lists all post", %{conn: conn} do
      conn = get(conn, ~p"/post")
      assert html_response(conn, 200) =~ "Listing Post"
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/post/new")
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/post", post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/post/#{id}"

      conn = get(conn, ~p"/post/#{id}")
      assert html_response(conn, 200) =~ "Post #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/post", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, ~p"/post/#{post}/edit")
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/post/#{post}", post: @update_attrs)
      assert redirected_to(conn) == ~p"/post/#{post}"

      conn = get(conn, ~p"/post/#{post}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/post/#{post}", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/post/#{post}")
      assert redirected_to(conn) == ~p"/post"

      assert_error_sent 404, fn ->
        get(conn, ~p"/post/#{post}")
      end
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
