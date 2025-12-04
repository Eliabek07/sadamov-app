import 'dart:typed_data';
import 'dart:convert';

class OccurrenceModel {
  final int? id;
  final String plate;
  final List<Uint8List> photos;
  final String? responsibleName;
  final Uint8List? signature;
  final DateTime createdAt;
  final DateTime? syncedAt;
  final bool isSynced;

  OccurrenceModel({
    this.id,
    required this.plate,
    required this.photos,
    this.responsibleName,
    this.signature,
    required this.createdAt,
    this.syncedAt,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plate': plate,
      'photos': photos.map((p) => base64Encode(p)).join(','),
      'responsible_name': responsibleName,
      'signature': signature != null ? base64Encode(signature!) : null,
      'created_at': createdAt.toIso8601String(),
      'synced_at': syncedAt?.toIso8601String(),
      'is_synced': isSynced ? 1 : 0,
    };
  }

  factory OccurrenceModel.fromJson(Map<String, dynamic> json) {
    final photosString = json['photos'] as String;
    final photosList = photosString.isEmpty 
        ? <Uint8List>[]
        : photosString
            .split(',')
            .where((p) => p.isNotEmpty)
            .map((p) => base64Decode(p))
            .toList();
    
    return OccurrenceModel(
      id: json['id'],
      plate: json['plate'],
      photos: photosList,
      responsibleName: json['responsible_name'],
      signature: json['signature'] != null 
          ? base64Decode(json['signature'] as String) 
          : null,
      createdAt: DateTime.parse(json['created_at']),
      syncedAt: json['synced_at'] != null 
          ? DateTime.parse(json['synced_at']) 
          : null,
      isSynced: json['is_synced'] == 1,
    );
  }
}

