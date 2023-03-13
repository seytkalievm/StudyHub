class Token {
  final String refreshToken;
  final String accessToken;

  Token({required this.accessToken, required this.refreshToken});

  Map<String, Object?> toJson() =>
      {"access": accessToken, "refresh": refreshToken};

  static Token fromJson(Map<String, Object?> json) => Token(
        accessToken: json["access"] as String,
        refreshToken: json["refresh"] as String,
      );

  @override
  String toString() => "refresh: $refreshToken \naccess: $accessToken";
}
