const String serverIP = "http://34.118.20.242:8000";
const int registerSuccessCode = 201;
const int registerCredentialsAlreadyExistCode = 400;
const int loginSuccessCode = 200;
const int loginWrongCredentialsCode = 401;
const String authorizationUri =
    "https://sso.university.innopolis.ru/adfs/oauth2/authorize/?response_type=code&client_id=02bdd68b-3508-40fa-aa30-c2b9e6f2f4c5&redirect_uri=https%3A%2F%2Fstudyhub.kz%2Foauth2%2Fcallback";
const String redirectUri = "https://studyhub.kz/oauth2/callback";
