import 'dart:convert';

import 'package:crypto/crypto.dart'; // Import the 'crypto' package

String getGravatarURL(String email) {
  // Trim leading and trailing whitespace from
  // an email address and force all characters
  // to lower case
  final address = email.trim().toLowerCase();

  // Create a SHA256 hash of the final string
  final bytes = utf8.encode(address); // Encode the string as bytes
  final hash = sha256.convert(bytes); // Create the SHA256 hash

  // Convert the hash bytes to a hexadecimal string
  final hashString = hash.toString();

  // Grab the actual image URL
  return 'https://www.gravatar.com/avatar/$hashString';
}
