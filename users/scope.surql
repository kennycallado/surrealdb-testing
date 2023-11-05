-- scope admin only allows signing
-- scope user regular users
-- ?? scope guest only allows signup

-- scope admin
DEFINE SCOPE admin SESSION 1d
  SIGNIN (SELECT * FROM users WHERE name = $name AND crypto::argon2::compare(pass, $pass));

-- scope user
DEFINE SCOPE user SESSION 1d
  SIGNUP (CREATE users SET email = $email, pass = crypto::argon2::generate($pass), name = $name, created = time::now())
  SIGNIN (SELECT * FROM users WHERE email = $email AND crypto::argon2::compare(pass, $pass));
