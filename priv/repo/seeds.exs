# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

for _index <- 1..50 do
  LiveElementsLabs.Factory.insert(:student)
end
