defmodule BuscaCepWeb.ReportController do
  use BuscaCepWeb, :controller

  action_fallback BuscaCepWeb.FallbackController

  def gen(conn, %{"email" => email} = _params) do
    task = Task.async(fn -> BuscaCep.gen_report() end)

    {:ok, filename} = Task.await(task)

    Task.start_link(fn -> BuscaCep.send_report(email, filename) end)

    resp(conn, :ok, "ok")
  end
end
