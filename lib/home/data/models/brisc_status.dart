import 'package:flutter/material.dart';

enum BriscStatus {
  noTumor(name: 'No Tumor', color: Colors.green),
  pituitary(name: 'Pituitary Tumor', color: Colors.blue),
  meningioma(name: 'Meningioma', color: Colors.orange),
  glioma(name: 'Glioma', color: Colors.red);

  final String name;
  final Color color;
  const BriscStatus({required this.name, required this.color});
}
