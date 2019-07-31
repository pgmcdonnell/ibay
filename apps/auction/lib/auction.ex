defmodule Auction do
  @moduledoc """
  Documentation for Auction.
  """
  alias Auction.Item

  @repo Auction.Repo

  def delete_item(%Auction.Item{} = item), do: @repo.delete(item)
  def get_item(id) do
    @repo.get!(Item, id)
  end
  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    Auction.Item
    |> struct(attrs)
    |> @repo.insert()
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
end
