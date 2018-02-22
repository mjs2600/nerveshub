defmodule Beamware.Accounts.Tenant do
  use Ecto.Schema

  import Ecto.Changeset

  alias Beamware.Accounts.{User, TenantKey}
  alias Beamware.Firmwares.Firmware
  alias Beamware.Devices.Device
  alias __MODULE__

  @type t :: %__MODULE__{}

  schema "tenants" do
    has_many(:users, User)
    has_many(:tenant_keys, TenantKey)
    has_many(:devices, Device)
    has_many(:firmware, Firmware)

    field(:name, :string)

    timestamps()
  end

  def changeset(%Tenant{} = tenant, params) do
    tenant
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
