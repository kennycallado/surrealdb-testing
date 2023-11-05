-- create admin
CREATE users CONTENT {
  name: 'admin',
  pass: crypto::argon2::generate('admin'),
  email: 'admin@lab.es',
}
