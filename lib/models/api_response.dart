class ApiResponse {
  final List<String> objects;
  final List<String> colors;

  const ApiResponse({required this.objects, required this.colors});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      objects: json['objects'],
      colors: json['colors'],
    );
  }
}
