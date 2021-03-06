defmodule Rocketmeals.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rocketmeals.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:descricao, :data, :calorias]
  @derive {Jason.Encoder, only: [:id, :descricao, :data, :calorias]}

  schema "meals" do
    field :descricao, :string
    field :data, :naive_datetime
    field :calorias, :integer
    has_many :users, User, on_delete: :nilify_all

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:calorias, greater_than_or_equal_to: 1)
  end
end
