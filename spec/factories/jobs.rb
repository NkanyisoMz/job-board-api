FactoryBot.define do
  factory :job do
    title { "MyString" }
    company_name { "MyString" }
    location { "MyString" }
    description { "MyText" }
    employment_type { "MyString" }
    experience_level { "MyString" }
    remote { false }
    salary_range { "MyString" }
    user { nil }
  end
end
