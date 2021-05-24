enum AuthType { user, admin }

Map<String, AuthType> nameToAuthType = {
  "admin": AuthType.admin,
  "user": AuthType.user,
};

Map<AuthType, String> authTypeToName = {
  AuthType.admin: "admin",
  AuthType.user: "user",
};
