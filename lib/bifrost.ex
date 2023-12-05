defmodule Bifrost do
  @moduledoc """
  Documentation for `Bifrost`.
  """
  require Logger

  def subscribe do
    Registry.register(Bifrost.Registry, "consumer", :consumer)
  end

  def get_message do
    receive do
      {:message, message} -> message
    end
  end

  def send_message(message) do
    Registry.dispatch(Bifrost.Registry, "socket_handler", fn entries ->
      for {pid, mode} <- entries do
        Logger.debug("a subscribed is #{inspect mode}")
        Logger.debug("Sending message to emacs #{message}")
        send(pid, {:send_to_emacs, message})
      end
    end)
  end
end
