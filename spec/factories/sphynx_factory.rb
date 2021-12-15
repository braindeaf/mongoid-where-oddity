FactoryBot.define do
  factory :sphynx do
    name { Faker::Creature::Cat.name }
  end
end
