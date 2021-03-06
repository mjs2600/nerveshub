defmodule NervesHubWeb.DeploymentView do
  use NervesHubWeb, :view

  alias NervesHub.Firmwares.Firmware
  alias NervesHub.Deployments.Deployment

  def firmware_dropdown_options(firmwares) do
    firmwares
    |> Enum.map(&[value: &1.id, key: firmware_display_name(&1)])
  end

  def firmware_display_name(%Firmware{} = f) do
    case Firmware.version(f) do
      {:ok, version} -> "#{version} (#{f.product})"
      {:error, _} -> f.product
    end
  end

  def version(%Deployment{conditions: %{"version" => ""}}), do: "-"
  def version(%Deployment{conditions: %{"version" => version}}), do: version

  def status(%Deployment{is_active: true}), do: "Active"
  def status(%Deployment{is_active: false}), do: "Inactive"

  def opposite_status(%Deployment{is_active: true}), do: "Inactive"
  def opposite_status(%Deployment{is_active: false}), do: "Active"

  def tags(%Deployment{conditions: %{"tags" => tags}}), do: tags
end
