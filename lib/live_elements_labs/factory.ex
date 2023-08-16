defmodule LiveElementsLabs.Factory do

  use ExMachina.Ecto, repo: LiveElementsLabs.Repo

  alias LiveElementsLabs.Students.Student

  def student_factory() do
    %Student{
      first_name: Faker.Person.En.first_name(),
      last_name: Faker.Person.En.last_name(),
      email: Faker.Internet.email(),
      experience_level: Enum.random([:beginner, :intermediate, :expert])
    }
  end
end
