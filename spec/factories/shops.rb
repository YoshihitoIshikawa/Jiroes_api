FactoryBot.define do
  factory :shop do
    access { "Test access" }
    address { "Test adress" }
    call_timing { "Test call timing" }
    closed_days { "Test closed days" }
    menu { "Test menu" }
    name { "Test name" }
    number_of_seats { "Test number of seats" }
    open_time { "Test open time" }
    parking { "Test parking" }
    phone_number { "Test phone number" }
    prohibited_matters { "Test prohibited matters" }
    remarks { "Test remarks" }
    when_to_buy_tickets { "Test when to buy tickets" }
  end
end
