User.create!(login: "egorcloud",
             email: "CloudEgor@yandex.ru",
             password:
               "123456789",
             password_confirmation: "123456789",
             admin: true,
             activated: true,
             activated_at: Time.zone.now
            )

99.times do
  login = Faker::Name.unique.first_name
  email = Faker::Internet.email
  password = Faker::Internet.password(min_length: 9)
  User.create!(login: login,
               email: email,
               password:
                 password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
              )
end