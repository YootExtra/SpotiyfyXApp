class TokenModel {
  final String access_token;
  final String token_type;
  final int expires_in;

  const TokenModel({
    required this.access_token,
    required this.token_type,
    required this.expires_in,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    final String? accessToken = json['access_token'] as String?;
    final String? tokenType = json['token_type'] as String?;
    final int? expiresIn = json['expires_in'] as int?;

    return switch (json) {
      {
        'access_token': String access_token,
        'token_type': String token_type,
        'expires_in': int expires_in,
      } =>
        TokenModel(
          access_token: access_token,
          token_type: token_type,
          expires_in: expires_in,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
