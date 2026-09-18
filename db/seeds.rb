# Only in development, allow logging in with user/password.
if Rails.env.development? && !User.exists?(username: "user")
  User.create!(
    username: "user",
    email: "user@dev.local",
    password: "password"
  )
end