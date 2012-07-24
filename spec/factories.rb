#symbol ':user" gets Factory Girl to simulate the User model

FactoryGirl.define do
  factory :user do
    name "Christopher Maynor"
    email "maynorc@mit.edu"
    password "foobar"
    password_confirmation "foobar"
  end
end