/// Feed Event Data Model — Phase 5.1
///
/// Represents a single activity event in the professional feed system.
/// Designed for law firm use cases (cases, documents, meetings, closures).
///
/// Example:
/// ```dart
/// final event = FeedEvent(
///   id: 'evt_001',
///   type: FeedEventType.caseAdded,
///   category: FeedEventCategory.caseManagement,
///   title: 'New Case: Smith vs. Johnson',
///   description: 'Civil litigation case opened',
///   timestamp: DateTime.now(),
///   author: 'Oscar Fausto',
/// );
/// ```
library;

/// Types of feed events in the legal professional context.
enum FeedEventType {
  /// New case added to the system
  caseAdded,

  /// Document uploaded to a case
  documentUploaded,

  /// Meeting scheduled with client or team
  meetingScheduled,

  /// Case marked as closed
  caseClosed,

  /// Reminder or deadline notification
  reminder,

  /// Comment or note added to a case
  commentAdded,

  /// Case status updated (in progress, pending, etc.)
  statusChanged,

  /// Client contact information updated
  clientUpdated,

  /// Payment received or invoice issued
  paymentReceived,

  /// Court hearing scheduled
  hearingScheduled,
}

/// Categories for organizing feed events.
enum FeedEventCategory {
  /// Case-related activities
  caseManagement,

  /// Document handling and storage
  documents,

  /// Calendar and scheduling
  scheduling,

  /// Financial transactions
  financial,

  /// Client communications
  clientRelations,

  /// Court and legal proceedings
  courtProceedings,

  /// Internal team collaboration
  teamCollaboration,

  /// System notifications and reminders
  notifications,
}

/// Immutable data model for a professional feed event.
///
/// Supports JSON serialization for persistence (Hive, Firestore, etc.).
class FeedEvent {
  /// Unique identifier for the event
  final String id;

  /// Type of the event (case added, document uploaded, etc.)
  final FeedEventType type;

  /// Category for filtering and organization
  final FeedEventCategory category;

  /// Primary title/headline of the event
  final String title;

  /// Detailed description (optional)
  final String? description;

  /// When the event occurred
  final DateTime timestamp;

  /// User who triggered the event
  final String author;

  /// Optional metadata for extensibility (case ID, document name, etc.)
  final Map<String, dynamic>? metadata;

  const FeedEvent({
    required this.id,
    required this.type,
    required this.category,
    required this.title,
    this.description,
    required this.timestamp,
    required this.author,
    this.metadata,
  });

  /// Creates a FeedEvent from a JSON map.
  factory FeedEvent.fromJson(Map<String, dynamic> json) {
    return FeedEvent(
      id: json['id'] as String,
      type: FeedEventType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => FeedEventType.reminder,
      ),
      category: FeedEventCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => FeedEventCategory.notifications,
      ),
      title: json['title'] as String,
      description: json['description'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      author: json['author'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Converts the FeedEvent to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'category': category.name,
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'author': author,
      'metadata': metadata,
    };
  }

  /// Creates a copy with optional field replacements.
  FeedEvent copyWith({
    String? id,
    FeedEventType? type,
    FeedEventCategory? category,
    String? title,
    String? description,
    DateTime? timestamp,
    String? author,
    Map<String, dynamic>? metadata,
  }) {
    return FeedEvent(
      id: id ?? this.id,
      type: type ?? this.type,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      author: author ?? this.author,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedEvent &&
        other.id == id &&
        other.type == type &&
        other.category == category &&
        other.title == title &&
        other.description == description &&
        other.timestamp == timestamp &&
        other.author == author;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      type,
      category,
      title,
      description,
      timestamp,
      author,
    );
  }

  @override
  String toString() {
    return 'FeedEvent(id: $id, type: ${type.name}, title: $title, '
        'timestamp: $timestamp, author: $author)';
  }
}
