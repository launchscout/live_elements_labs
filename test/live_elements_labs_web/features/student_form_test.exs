defmodule LiveElementsLabsWeb.Features.StudentFormTest do
  use ExUnit.Case, async: false
  use Wallaby.Feature

  import Wallaby.Query
  import LiveElementsLabs.Factory

  test "sign up", %{session: session} do
    session
    |> visit("/student_form")
    |> find(css("student-form"))
    |> shadow_root()
    |> fill_in(css("input[name='first_name']"), with: "Bob")
    |> fill_in(css("input[name='last_name']"), with: "Bob")
    |> fill_in(css("input[name='email']"), with: "bob@example.com")
    |> click(css("select[name='experience_level']"))
    |> click(css("option[value='expert']"))
    |> click(css("button", text: "Register"))
    |> assert_has(css("p", text: "Thank you"))
  end

  test "emails must be unique", %{session: session} do
    student = insert(:student, email: "bob@example.com")
    session
    |> visit("/student_form")
    |> find(css("student-form"))
    |> shadow_root()
    |> fill_in(css("input[name='first_name']"), with: "Bob")
    |> fill_in(css("input[name='last_name']"), with: "Bob")
    |> fill_in(css("input[name='email']"), with: "bob@example.com")
    |> click(css("select[name='experience_level']"))
    |> click(css("option[value='expert']"))
    |> click(css("button", text: "Register"))
    |> assert_has(css(".error", text: "has already been taken"))
  end
end
