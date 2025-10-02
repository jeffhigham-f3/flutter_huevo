enum AuthMethod {
  emailAndPassword('email-and-password'),
  google('google'),
  apple('apple'),
  anonymous('anonymous');

  const AuthMethod(this.id);

  final String id;
}
