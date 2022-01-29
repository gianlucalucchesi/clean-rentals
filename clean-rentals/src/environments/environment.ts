export const environment = {
  production: false,
  ApiUrl: 'https://localhost:8080/api/', // used as reusable var in service
  auth: {
    domain: 'dev-qkw53hzi.eu.auth0.com',
    clientId: 'zs22JkuRKqL7isbB4AkqWv75C0KvHmXB',
    audience: 'https://localhost:8080/',
    redirectUri: window.location.origin,
  },
  httpInterceptor: {
    allowedList: [
      'https://localhost:8080/api/*',
      {
        tokenOptions: {
          audience: 'https://localhost:8080',
          //scope: 'read:cars write:cars read:brands write:brands',
          scope: 'read: cars',
        },
      },
    ],
  },
};
