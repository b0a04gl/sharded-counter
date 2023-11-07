defmodule CounterWeb.Counter do
  use CounterWeb, :live_view
  alias Counter.Count
  alias Phoenix.PubSub

  @topic Count.topic

  def mount(_params, _session, socket) do
    PubSub.subscribe(Counter.PubSub, @topic)

    {:ok, assign(socket, val: Count.current()) }
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :val, Count.incr())}
  end

  def handle_event("dec", _, socket) do
    {:noreply, assign(socket, :val, Count.decr())}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, val: count)}
  end

  def render(assigns) do
    ~H"""
    <div style="text-align: center; font-family: Arial, sans-serif; margin: 20px;">
  <h1 style="font-size: 24px; color: #333;">The count is: <span style="font-size: 36px; font-weight: bold; color: #007BFF; margin: 0 10px;"><%= @val %></span></h1>
  <button style="background-color: #007BFF; color: #fff; font-size: 20px; padding: 10px 20px; border: none; cursor: pointer; margin: 0 10px; transition: background-color 0.3s ease, transform 0.1s ease;" phx-click="dec">-</button>
  <button style="background-color: #FF6C37; color: #fff; font-size: 20px; padding: 10px 20px; border: none; cursor: pointer; margin: 0 10px; transition: background-color 0.3s ease, transform 0.1s ease;" phx-click="inc">+</button>
</div>

    """
  end
end
