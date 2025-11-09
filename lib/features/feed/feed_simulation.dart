/// Feed Simulation Service — Phase 5.1
///
/// Lightweight service for generating and managing simulated feed data.
/// Provides filtering, sorting, and randomization for testing UI components.
///
/// Example:
/// ```dart
/// final simulation = FeedSimulation();
/// final events = await simulation.fetchFeed();
/// final caseEvents = await simulation.fetchFeedByCategory(FeedEventCategory.caseManagement);
/// ```
library;

import 'dart:math';
import 'models/feed_event.dart';
import 'mock/feed_mock_data.dart';

/// Service for simulating professional feed data without backend integration.
///
/// This is a pure data layer service - UI-agnostic and ready for later
/// integration with Hive, Firestore, or REST APIs.
class FeedSimulation {
  final Random _random = Random();

  /// Fetches the complete feed with all events.
  ///
  /// Returns events sorted chronologically (most recent first).
  /// Simulates a slight network delay for realistic behavior.
  Future<List<FeedEvent>> fetchFeed() async {
    // Simulate network delay (50-150ms)
    await Future.delayed(Duration(milliseconds: 50 + _random.nextInt(100)));

    return FeedMockData.generateMockFeed();
  }

  /// Fetches feed events filtered by category.
  ///
  /// Returns only events matching the specified category,
  /// sorted chronologically (most recent first).
  Future<List<FeedEvent>> fetchFeedByCategory(
    FeedEventCategory category,
  ) async {
    await Future.delayed(Duration(milliseconds: 30 + _random.nextInt(70)));

    return FeedMockData.getMockFeedByCategory(category);
  }

  /// Fetches feed events filtered by type.
  ///
  /// Returns only events matching the specified type,
  /// sorted chronologically (most recent first).
  Future<List<FeedEvent>> fetchFeedByType(FeedEventType type) async {
    await Future.delayed(Duration(milliseconds: 30 + _random.nextInt(70)));

    return FeedMockData.getMockFeedByType(type);
  }

  /// Fetches recent feed events (last 24 hours only).
  ///
  /// Useful for showing "today's activity" views.
  Future<List<FeedEvent>> fetchRecentFeed() async {
    await Future.delayed(Duration(milliseconds: 20 + _random.nextInt(50)));

    return FeedMockData.getRecentMockFeed();
  }

  /// Fetches feed events with custom filtering and sorting.
  ///
  /// Parameters:
  /// - [categories]: Filter by one or more categories (null = all)
  /// - [types]: Filter by one or more types (null = all)
  /// - [author]: Filter by author name (null = all)
  /// - [sortAscending]: Sort order (false = newest first, true = oldest first)
  /// - [limit]: Maximum number of events to return (null = all)
  Future<List<FeedEvent>> fetchFeedWithFilters({
    List<FeedEventCategory>? categories,
    List<FeedEventType>? types,
    String? author,
    bool sortAscending = false,
    int? limit,
  }) async {
    await Future.delayed(Duration(milliseconds: 40 + _random.nextInt(80)));

    var events = FeedMockData.generateMockFeed();

    // Apply category filter
    if (categories != null && categories.isNotEmpty) {
      events = events
          .where((event) => categories.contains(event.category))
          .toList();
    }

    // Apply type filter
    if (types != null && types.isNotEmpty) {
      events = events.where((event) => types.contains(event.type)).toList();
    }

    // Apply author filter
    if (author != null && author.isNotEmpty) {
      events = events
          .where((event) =>
              event.author.toLowerCase().contains(author.toLowerCase()))
          .toList();
    }

    // Apply sorting
    if (sortAscending) {
      events.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    } else {
      events.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }

    // Apply limit
    if (limit != null && limit > 0) {
      events = events.take(limit).toList();
    }

    return events;
  }

  /// Generates a random feed with varying event counts.
  ///
  /// Useful for stress-testing UI components with different data sizes.
  /// Event count ranges from [minCount] to [maxCount].
  Future<List<FeedEvent>> fetchRandomFeed({
    int minCount = 5,
    int maxCount = 30,
  }) async {
    await Future.delayed(Duration(milliseconds: 50 + _random.nextInt(100)));

    final allEvents = FeedMockData.generateMockFeed();
    final count = minCount + _random.nextInt(maxCount - minCount + 1);

    // Shuffle and take random subset
    final shuffled = List<FeedEvent>.from(allEvents)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// Simulates adding a new event to the feed.
  ///
  /// In a real implementation, this would POST to a backend API.
  /// For now, it validates the event and returns success.
  Future<bool> addEvent(FeedEvent event) async {
    await Future.delayed(Duration(milliseconds: 100 + _random.nextInt(200)));

    // Simulate validation
    if (event.title.isEmpty || event.author.isEmpty) {
      return false;
    }

    // In real implementation: persist to database/backend
    // For simulation: just return success
    return true;
  }

  /// Simulates deleting an event from the feed.
  ///
  /// In a real implementation, this would DELETE from a backend API.
  Future<bool> deleteEvent(String eventId) async {
    await Future.delayed(Duration(milliseconds: 80 + _random.nextInt(150)));

    // In real implementation: delete from database/backend
    // For simulation: just return success
    return true;
  }

  /// Searches feed events by keyword in title or description.
  ///
  /// Returns events containing the search query (case-insensitive).
  Future<List<FeedEvent>> searchFeed(String query) async {
    await Future.delayed(Duration(milliseconds: 30 + _random.nextInt(70)));

    if (query.isEmpty) {
      return FeedMockData.generateMockFeed();
    }

    final lowerQuery = query.toLowerCase();
    return FeedMockData.generateMockFeed()
        .where((event) =>
            event.title.toLowerCase().contains(lowerQuery) ||
            (event.description?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  /// Gets event count statistics by category.
  ///
  /// Returns a map of category -> event count.
  Future<Map<FeedEventCategory, int>> getEventCountByCategory() async {
    await Future.delayed(Duration(milliseconds: 20 + _random.nextInt(50)));

    final events = FeedMockData.generateMockFeed();
    final counts = <FeedEventCategory, int>{};

    for (final event in events) {
      counts[event.category] = (counts[event.category] ?? 0) + 1;
    }

    return counts;
  }

  /// Gets event count statistics by type.
  ///
  /// Returns a map of type -> event count.
  Future<Map<FeedEventType, int>> getEventCountByType() async {
    await Future.delayed(Duration(milliseconds: 20 + _random.nextInt(50)));

    final events = FeedMockData.generateMockFeed();
    final counts = <FeedEventType, int>{};

    for (final event in events) {
      counts[event.type] = (counts[event.type] ?? 0) + 1;
    }

    return counts;
  }

  /// Gets events grouped by date (YYYY-MM-DD).
  ///
  /// Returns a map of date string -> list of events for that day.
  /// Useful for building timeline-style UIs.
  Future<Map<String, List<FeedEvent>>> getEventsGroupedByDate() async {
    await Future.delayed(Duration(milliseconds: 30 + _random.nextInt(70)));

    final events = FeedMockData.generateMockFeed();
    final grouped = <String, List<FeedEvent>>{};

    for (final event in events) {
      final dateKey =
          '${event.timestamp.year}-${event.timestamp.month.toString().padLeft(2, '0')}-${event.timestamp.day.toString().padLeft(2, '0')}';

      grouped.putIfAbsent(dateKey, () => []).add(event);
    }

    return grouped;
  }

  /// Simulates a "pull to refresh" action.
  ///
  /// Returns the full feed with a simulated refresh delay.
  /// In a real implementation, this would fetch fresh data from the backend.
  Future<List<FeedEvent>> refreshFeed() async {
    // Simulate longer refresh delay (200-500ms)
    await Future.delayed(Duration(milliseconds: 200 + _random.nextInt(300)));

    return FeedMockData.generateMockFeed();
  }

  /// Simulates pagination by returning events in chunks.
  ///
  /// Parameters:
  /// - [page]: Page number (0-indexed)
  /// - [pageSize]: Number of events per page
  ///
  /// Returns events for the specified page.
  Future<List<FeedEvent>> fetchFeedPage({
    int page = 0,
    int pageSize = 10,
  }) async {
    await Future.delayed(Duration(milliseconds: 40 + _random.nextInt(80)));

    final allEvents = FeedMockData.generateMockFeed();
    final startIndex = page * pageSize;

    if (startIndex >= allEvents.length) {
      return [];
    }

    final endIndex = (startIndex + pageSize).clamp(0, allEvents.length);
    return allEvents.sublist(startIndex, endIndex);
  }

  /// Gets total event count (for pagination UI).
  Future<int> getTotalEventCount() async {
    await Future.delayed(Duration(milliseconds: 10 + _random.nextInt(30)));

    return FeedMockData.generateMockFeed().length;
  }
}
