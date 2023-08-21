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
    |> fill_in(text_field("first_name"), with: "Bob")
    |> fill_in(text_field("last_name"), with: "Jones")
    |> fill_in(text_field("email"), with: "bobjones@example.com")
    |> click(option("beginner"))
    |> click(css("button", text: "Sign Up"))
    |> assert_has(css("div", text: "Thanks"))
  end
end
