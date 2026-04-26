class SendMessageRequestModel {
  final String message;

  SendMessageRequestModel({required this.message});

  Map<String, dynamic> toJson() => {
    "contents": [
      {
        "parts": [
          {"text": message},
        ],
      },
    ],
  };
}
