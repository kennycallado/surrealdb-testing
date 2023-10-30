-- scope
DEFINE SCOPE user SESSION 1d
  SIGNUP (CREATE users SET email = $email, pass = crypto::argon2::generate($pass), name = $name, active = true, project = $project, created = time::now())
  SIGNIN (SELECT * FROM users WHERE email = $email AND crypto::argon2::compare(pass, $pass));
