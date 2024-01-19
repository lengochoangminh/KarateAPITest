function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  var config = {
    apiURL: 'https://api.realworld.io/api/'
  }

  if (env == 'dev') {
    config.userEmail = 'karate@test.com'
    config.userPassword = 'karate123'
  } else if (env == 'e2e') {
    config.userEmail = 'karate2@test.com'
    config.userPassword = 'karate456'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', { Authorization: 'Token ' + accessToken })

  return config;
}