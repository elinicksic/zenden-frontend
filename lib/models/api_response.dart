class ApiResponse {
  final List<dynamic> objects;
  final Map<dynamic, dynamic> colors;
  final Map<dynamic, dynamic> scoring;

  const ApiResponse(
      {required this.objects, required this.colors, required this.scoring});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      objects: json['objects'],
      colors: json['colors'],
      scoring: json['scoring'],
    );
  }

  @override
  String toString() {
    return 'ApiResponse{objects: $objects, colors: $colors}';
  }
}
