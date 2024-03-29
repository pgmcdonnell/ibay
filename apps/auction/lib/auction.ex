defmodule Auction do
  @moduledoc """
  Documentation for Auction.
  """
  alias Auction.{Item, User, Password}

  @repo Auction.Repo

  def delete_item(%Auction.Item{} = item), do: @repo.delete(item)
  def get_item(id) do
    @repo.get!(Item, id)
  end
  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def list_items do
    @repo.all(Item)
  end

  def update_item(%Auction.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()
  end

  def new_item, do: Item.changeset(%Item{})

  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> @repo.insert()
  end

  def edit_item(id) do
    id
    |> get_item()
    |> Item.changeset()
  end

  def get_user(id), do: @repo.get!(User, id)

  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
      true <- Password.verify_with_hash(password, user.hashed_password) do
        user
      else
        _ -> Password.dummy_verify
      end
  end

  def new_user(), do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert
  end
end
