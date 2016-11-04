defmodule Simulator.MeetupServer do

  use GenServer
  @me __MODULE__

  def start_link() do
    GenServer.start __MODULE__, [], name: @me
  end

  def register_user() do
    GenServer.call @me, {:register}
  end

  def get_users() do
    GenServer.call @me, {:get_users}
  end


#Implementation

  def init(state), do: {:ok, state}


  #FIX all this crap (TODO and BUG)
  #This needs to not have duplicates and not return self to requester
  def handle_call {:register}, from, state do
    {:reply, state, [Kernel.elem(from, 0) | state]}
  end

  def handle_call {:get_users}, from, state do
    {:reply, Enum.reject(state, &(&1 == Kernel.elem(from, 0))), state}
  end

end