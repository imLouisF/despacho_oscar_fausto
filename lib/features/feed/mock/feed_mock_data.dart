/// Mock Feed Data — Phase 5.1
///
/// Realistic law firm feed events for early visualization and widget testing.
/// Provides a curated dataset representing typical professional activities.
library;

import '../models/feed_event.dart';

/// Generates a list of mock feed events for testing and development.
///
/// Events simulate a 7-day timeline with varied professional activities.
/// All timestamps are offset from DateTime.now() for chronological ordering.
class FeedMockData {
  FeedMockData._();

  /// Law firm team members
  static const _authors = [
    'Oscar Fausto',
    'María González',
    'Carlos Ramírez',
    'Ana Martínez',
    'Luis Hernández',
  ];

  /// Generates a comprehensive mock feed dataset.
  ///
  /// Returns 20+ events spanning various categories and types,
  /// sorted chronologically (most recent first).
  static List<FeedEvent> generateMockFeed() {
    final now = DateTime.now();

    return [
      // Recent events (today)
      FeedEvent(
        id: 'evt_001',
        type: FeedEventType.documentUploaded,
        category: FeedEventCategory.documents,
        title: 'Contrato firmado - García Corp',
        description: 'Contrato de servicios legales 2025.pdf',
        timestamp: now.subtract(const Duration(minutes: 15)),
        author: _authors[1],
        metadata: {
          'caseId': 'case_105',
          'documentName': 'contrato_servicios_2025.pdf',
          'fileSize': '2.4 MB',
        },
      ),
      FeedEvent(
        id: 'evt_002',
        type: FeedEventType.reminder,
        category: FeedEventCategory.notifications,
        title: 'Audiencia mañana - Caso Medina',
        description: 'Preparar documentación para audiencia preliminar',
        timestamp: now.subtract(const Duration(hours: 1)),
        author: 'Sistema',
        metadata: {
          'caseId': 'case_098',
          'dueDate': now.add(const Duration(days: 1)).toIso8601String(),
        },
      ),
      FeedEvent(
        id: 'evt_003',
        type: FeedEventType.meetingScheduled,
        category: FeedEventCategory.scheduling,
        title: 'Reunión con Familia López',
        description: 'Consulta inicial - Sucesión testamentaria',
        timestamp: now.subtract(const Duration(hours: 2)),
        author: _authors[0],
        metadata: {
          'meetingDate': now.add(const Duration(days: 3)).toIso8601String(),
          'duration': 60,
          'location': 'Oficina Principal',
        },
      ),

      // Yesterday
      FeedEvent(
        id: 'evt_004',
        type: FeedEventType.caseAdded,
        category: FeedEventCategory.caseManagement,
        title: 'Nuevo caso: Constructora Silva',
        description: 'Litigio laboral - Despido injustificado',
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
        author: _authors[2],
        metadata: {
          'caseId': 'case_106',
          'caseType': 'Laboral',
          'priority': 'Alta',
        },
      ),
      FeedEvent(
        id: 'evt_005',
        type: FeedEventType.commentAdded,
        category: FeedEventCategory.teamCollaboration,
        title: 'Comentario en caso TechStart',
        description: 'Revisé la documentación fiscal. Necesitamos certificados actualizados.',
        timestamp: now.subtract(const Duration(days: 1, hours: 5)),
        author: _authors[3],
        metadata: {
          'caseId': 'case_103',
        },
      ),
      FeedEvent(
        id: 'evt_006',
        type: FeedEventType.paymentReceived,
        category: FeedEventCategory.financial,
        title: 'Pago recibido - Grupo Comercial Ruiz',
        description: 'Anticipo de honorarios: \$15,000 MXN',
        timestamp: now.subtract(const Duration(days: 1, hours: 8)),
        author: 'Sistema',
        metadata: {
          'caseId': 'case_099',
          'amount': 15000,
          'currency': 'MXN',
          'paymentMethod': 'Transferencia',
        },
      ),

      // 2 days ago
      FeedEvent(
        id: 'evt_007',
        type: FeedEventType.hearingScheduled,
        category: FeedEventCategory.courtProceedings,
        title: 'Audiencia programada - Caso Medina',
        description: 'Juzgado Civil 5° - Sala B',
        timestamp: now.subtract(const Duration(days: 2, hours: 2)),
        author: _authors[0],
        metadata: {
          'caseId': 'case_098',
          'courtDate': now.add(const Duration(days: 2)).toIso8601String(),
          'courtRoom': 'Sala B',
          'judge': 'Juez Morales',
        },
      ),
      FeedEvent(
        id: 'evt_008',
        type: FeedEventType.statusChanged,
        category: FeedEventCategory.caseManagement,
        title: 'Caso actualizado: García Corp',
        description: 'Estado: Revisión de documentos → En negociación',
        timestamp: now.subtract(const Duration(days: 2, hours: 6)),
        author: _authors[1],
        metadata: {
          'caseId': 'case_105',
          'previousStatus': 'Revisión de documentos',
          'newStatus': 'En negociación',
        },
      ),

      // 3 days ago
      FeedEvent(
        id: 'evt_009',
        type: FeedEventType.documentUploaded,
        category: FeedEventCategory.documents,
        title: 'Demanda presentada - Familia López',
        description: 'demanda_sucesion_lopez.pdf',
        timestamp: now.subtract(const Duration(days: 3, hours: 4)),
        author: _authors[4],
        metadata: {
          'caseId': 'case_104',
          'documentName': 'demanda_sucesion_lopez.pdf',
          'fileSize': '3.8 MB',
        },
      ),
      FeedEvent(
        id: 'evt_010',
        type: FeedEventType.clientUpdated,
        category: FeedEventCategory.clientRelations,
        title: 'Cliente actualizado: TechStart Solutions',
        description: 'Nuevo contacto agregado: Director Legal',
        timestamp: now.subtract(const Duration(days: 3, hours: 7)),
        author: _authors[2],
        metadata: {
          'clientId': 'client_045',
          'updateType': 'contact',
        },
      ),

      // 4 days ago
      FeedEvent(
        id: 'evt_011',
        type: FeedEventType.meetingScheduled,
        category: FeedEventCategory.scheduling,
        title: 'Reunión de seguimiento - Caso Silva',
        description: 'Revisión de estrategia procesal',
        timestamp: now.subtract(const Duration(days: 4, hours: 1)),
        author: _authors[2],
        metadata: {
          'caseId': 'case_106',
          'meetingDate': now.add(const Duration(days: 5)).toIso8601String(),
          'duration': 90,
          'attendees': ['Oscar Fausto', 'Carlos Ramírez', 'Cliente'],
        },
      ),
      FeedEvent(
        id: 'evt_012',
        type: FeedEventType.reminder,
        category: FeedEventCategory.notifications,
        title: 'Vencimiento de plazo - Caso Ruiz',
        description: 'Presentar alegatos finales antes del viernes',
        timestamp: now.subtract(const Duration(days: 4, hours: 9)),
        author: 'Sistema',
        metadata: {
          'caseId': 'case_099',
          'dueDate': now.add(const Duration(days: 3)).toIso8601String(),
        },
      ),

      // 5 days ago
      FeedEvent(
        id: 'evt_013',
        type: FeedEventType.caseClosed,
        category: FeedEventCategory.caseManagement,
        title: 'Caso cerrado: Industrias Medina',
        description: 'Acuerdo extrajudicial alcanzado - Caso resuelto satisfactoriamente',
        timestamp: now.subtract(const Duration(days: 5, hours: 5)),
        author: _authors[0],
        metadata: {
          'caseId': 'case_097',
          'resolution': 'Acuerdo extrajudicial',
          'closureReason': 'Caso resuelto',
        },
      ),
      FeedEvent(
        id: 'evt_014',
        type: FeedEventType.documentUploaded,
        category: FeedEventCategory.documents,
        title: 'Evidencia agregada - Caso Silva',
        description: 'contratos_laborales_2024.zip (5 archivos)',
        timestamp: now.subtract(const Duration(days: 5, hours: 8)),
        author: _authors[3],
        metadata: {
          'caseId': 'case_106',
          'documentName': 'contratos_laborales_2024.zip',
          'fileSize': '12.1 MB',
          'fileCount': 5,
        },
      ),

      // 6 days ago
      FeedEvent(
        id: 'evt_015',
        type: FeedEventType.caseAdded,
        category: FeedEventCategory.caseManagement,
        title: 'Nuevo caso: Grupo Comercial Ruiz',
        description: 'Asesoría mercantil - Constitución de sociedad',
        timestamp: now.subtract(const Duration(days: 6, hours: 2)),
        author: _authors[0],
        metadata: {
          'caseId': 'case_099',
          'caseType': 'Mercantil',
          'priority': 'Media',
        },
      ),
      FeedEvent(
        id: 'evt_016',
        type: FeedEventType.commentAdded,
        category: FeedEventCategory.teamCollaboration,
        title: 'Comentario en caso García Corp',
        description: 'Cliente solicitó modificaciones al contrato. Revisar cláusulas 5 y 7.',
        timestamp: now.subtract(const Duration(days: 6, hours: 6)),
        author: _authors[1],
        metadata: {
          'caseId': 'case_105',
        },
      ),

      // 7 days ago
      FeedEvent(
        id: 'evt_017',
        type: FeedEventType.hearingScheduled,
        category: FeedEventCategory.courtProceedings,
        title: 'Audiencia programada - Caso López',
        description: 'Juzgado Familiar 3° - Sala A',
        timestamp: now.subtract(const Duration(days: 7, hours: 3)),
        author: _authors[4],
        metadata: {
          'caseId': 'case_104',
          'courtDate': now.add(const Duration(days: 10)).toIso8601String(),
          'courtRoom': 'Sala A',
          'judge': 'Jueza Sánchez',
        },
      ),
      FeedEvent(
        id: 'evt_018',
        type: FeedEventType.paymentReceived,
        category: FeedEventCategory.financial,
        title: 'Pago recibido - Constructora Silva',
        description: 'Anticipo inicial: \$20,000 MXN',
        timestamp: now.subtract(const Duration(days: 7, hours: 7)),
        author: 'Sistema',
        metadata: {
          'caseId': 'case_106',
          'amount': 20000,
          'currency': 'MXN',
          'paymentMethod': 'Efectivo',
        },
      ),
      FeedEvent(
        id: 'evt_019',
        type: FeedEventType.statusChanged,
        category: FeedEventCategory.caseManagement,
        title: 'Caso actualizado: TechStart Solutions',
        description: 'Estado: Abierto → En revisión',
        timestamp: now.subtract(const Duration(days: 7, hours: 10)),
        author: _authors[3],
        metadata: {
          'caseId': 'case_103',
          'previousStatus': 'Abierto',
          'newStatus': 'En revisión',
        },
      ),
      FeedEvent(
        id: 'evt_020',
        type: FeedEventType.meetingScheduled,
        category: FeedEventCategory.scheduling,
        title: 'Consulta inicial - García Corp',
        description: 'Primera reunión con cliente nuevo',
        timestamp: now.subtract(const Duration(days: 7, hours: 12)),
        author: _authors[1],
        metadata: {
          'clientId': 'client_050',
          'meetingDate': now.subtract(const Duration(days: 6)).toIso8601String(),
          'duration': 45,
          'location': 'Oficina Principal',
        },
      ),
    ];
  }

  /// Generates a subset of events filtered by category.
  static List<FeedEvent> getMockFeedByCategory(FeedEventCategory category) {
    return generateMockFeed()
        .where((event) => event.category == category)
        .toList();
  }

  /// Generates a subset of events filtered by type.
  static List<FeedEvent> getMockFeedByType(FeedEventType type) {
    return generateMockFeed().where((event) => event.type == type).toList();
  }

  /// Generates recent events (last 24 hours).
  static List<FeedEvent> getRecentMockFeed() {
    final now = DateTime.now();
    return generateMockFeed()
        .where((event) => event.timestamp.isAfter(now.subtract(const Duration(days: 1))))
        .toList();
  }
}
