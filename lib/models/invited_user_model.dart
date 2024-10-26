class InvitedUser {
  final int id;
  final String invitedEmail;
  final String status;
  final String image;

  InvitedUser({
    required this.id,
    required this.invitedEmail,
    required this.status,
    required this.image,
  });

  // Factory method to create an instance from JSON
  factory InvitedUser.fromJson(Map<String, dynamic> json) {
    return InvitedUser(
      id: json['id'],
      invitedEmail: json['invited_email'],
      status: json['status'],
      image: json['image'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invited_email': invitedEmail,
      'status': status,
      'image': image,
    };
  }
}
