class FirebaseConfig {
  const FirebaseConfig({
    this.apiKey = '',
    this.appId = '',
    this.messagingSenderId = '',
    this.projectId = '',
    this.storageBucket = '',
    this.authDomain = '',
    this.measurementId = '',
    this.enabled = false,
  });

  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String storageBucket;
  final String authDomain;
  final String measurementId;
  final bool enabled;

  FirebaseConfig copyWith({
    String? apiKey,
    String? appId,
    String? messagingSenderId,
    String? projectId,
    String? storageBucket,
    String? authDomain,
    String? measurementId,
    bool? enabled,
  }) {
    return FirebaseConfig(
      apiKey: apiKey ?? this.apiKey,
      appId: appId ?? this.appId,
      messagingSenderId: messagingSenderId ?? this.messagingSenderId,
      projectId: projectId ?? this.projectId,
      storageBucket: storageBucket ?? this.storageBucket,
      authDomain: authDomain ?? this.authDomain,
      measurementId: measurementId ?? this.measurementId,
      enabled: enabled ?? this.enabled,
    );
  }
}
