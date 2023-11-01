// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firefly_iii_v2.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSum _$TransactionSumFromJson(Map<String, dynamic> json) =>
    TransactionSum(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      code: json['code'] as String,
      decimalPlaces: json['decimal_places'] as int,
      sum: json['sum'] as String,
      converted: json['converted'] as bool,
      nativeSum: json['native_sum'] as String,
      nativeId: json['native_id'] as String,
      nativeName: json['native_name'] as String,
      nativeSymbol: json['native_symbol'] as String,
      nativeCode: json['native_code'] as String,
      nativeDecimalPlaces: json['native_decimal_places'] as int,
    );

Map<String, dynamic> _$TransactionSumToJson(TransactionSum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'code': instance.code,
      'decimal_places': instance.decimalPlaces,
      'sum': instance.sum,
      'converted': instance.converted,
      'native_sum': instance.nativeSum,
      'native_id': instance.nativeId,
      'native_name': instance.nativeName,
      'native_symbol': instance.nativeSymbol,
      'native_code': instance.nativeCode,
      'native_decimal_places': instance.nativeDecimalPlaces,
    };

BudgetLimitV2 _$BudgetLimitV2FromJson(Map<String, dynamic> json) =>
    BudgetLimitV2(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencyName: json['currency_name'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      budgetId: json['budget_id'] as String,
      period: json['period'] as String?,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$BudgetLimitV2ToJson(BudgetLimitV2 instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'start': instance.start.toIso8601String(),
    'end': instance.end.toIso8601String(),
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_name': instance.currencyName,
    'currency_symbol': instance.currencySymbol,
    'currency_decimal_places': instance.currencyDecimalPlaces,
    'budget_id': instance.budgetId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('period', instance.period);
  val['amount'] = instance.amount;
  return val;
}

BudgetLimitV2Array _$BudgetLimitV2ArrayFromJson(Map<String, dynamic> json) =>
    BudgetLimitV2Array(
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => BudgetLimitReadV2.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitV2ArrayToJson(BudgetLimitV2Array instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

BudgetLimitReadV2 _$BudgetLimitReadV2FromJson(Map<String, dynamic> json) =>
    BudgetLimitReadV2(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          BudgetLimitV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetLimitReadV2ToJson(BudgetLimitReadV2 instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

BudgetV2 _$BudgetV2FromJson(Map<String, dynamic> json) => BudgetV2(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      active: json['active'] as bool,
      order: json['order'] as int,
    );

Map<String, dynamic> _$BudgetV2ToJson(BudgetV2 instance) => <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'active': instance.active,
      'order': instance.order,
    };

BudgetV2Array _$BudgetV2ArrayFromJson(Map<String, dynamic> json) =>
    BudgetV2Array(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => BudgetV2Read.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetV2ArrayToJson(BudgetV2Array instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };

BudgetV2Read _$BudgetV2ReadFromJson(Map<String, dynamic> json) => BudgetV2Read(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes: BudgetV2.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetV2ReadToJson(BudgetV2Read instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

ChartDataPointV2 _$ChartDataPointV2FromJson(Map<String, dynamic> json) =>
    ChartDataPointV2(
      key: json['key'] as String,
    );

Map<String, dynamic> _$ChartDataPointV2ToJson(ChartDataPointV2 instance) =>
    <String, dynamic>{
      'key': instance.key,
    };

ChartDataSetV2 _$ChartDataSetV2FromJson(Map<String, dynamic> json) =>
    ChartDataSetV2(
      label: json['label'] as String,
      currencyId: json['currency_id'] as String,
      currencyCode: json['currency_code'] as String,
      currencySymbol: json['currency_symbol'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      nativeId: json['native_id'] as String,
      nativeCode: json['native_code'] as String,
      nativeSymbol: json['native_symbol'] as String,
      nativeDecimalPlaces: json['native_decimal_places'] as int,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      period: chartV2PeriodPropertyNullableFromJson(json['period']),
      entries: json['entries'] as Object,
      nativeEntries: json['native_entries'] as Object,
    );

Map<String, dynamic> _$ChartDataSetV2ToJson(ChartDataSetV2 instance) {
  final val = <String, dynamic>{
    'label': instance.label,
    'currency_id': instance.currencyId,
    'currency_code': instance.currencyCode,
    'currency_symbol': instance.currencySymbol,
    'currency_decimal_places': instance.currencyDecimalPlaces,
    'native_id': instance.nativeId,
    'native_code': instance.nativeCode,
    'native_symbol': instance.nativeSymbol,
    'native_decimal_places': instance.nativeDecimalPlaces,
    'start': instance.start.toIso8601String(),
    'end': instance.end.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('period', chartV2PeriodPropertyNullableToJson(instance.period));
  val['entries'] = instance.entries;
  val['native_entries'] = instance.nativeEntries;
  return val;
}

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      data: PolymorphicProperty.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'data': instance.data.toJson(),
    };

PreferenceRead _$PreferenceReadFromJson(Map<String, dynamic> json) =>
    PreferenceRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Preference.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceReadToJson(PreferenceRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

PreferenceSingle _$PreferenceSingleFromJson(Map<String, dynamic> json) =>
    PreferenceSingle(
      data: PreferenceRead.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreferenceSingleToJson(PreferenceSingle instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

PolymorphicProperty _$PolymorphicPropertyFromJson(Map<String, dynamic> json) =>
    PolymorphicProperty();

Map<String, dynamic> _$PolymorphicPropertyToJson(
        PolymorphicProperty instance) =>
    <String, dynamic>{};

TransactionArray _$TransactionArrayFromJson(Map<String, dynamic> json) =>
    TransactionArray(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => TransactionRead.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      links: PageLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionArrayToJson(TransactionArray instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
      'links': instance.links.toJson(),
    };

TransactionRead _$TransactionReadFromJson(Map<String, dynamic> json) =>
    TransactionRead(
      type: json['type'] as String,
      id: json['id'] as String,
      attributes:
          Transaction.fromJson(json['attributes'] as Map<String, dynamic>),
      links: ObjectLink.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionReadToJson(TransactionRead instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'links': instance.links.toJson(),
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      pagination:
          Meta$Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'pagination': instance.pagination.toJson(),
    };

ObjectLink _$ObjectLinkFromJson(Map<String, dynamic> json) => ObjectLink(
      self: json['self'] as String,
    );

Map<String, dynamic> _$ObjectLinkToJson(ObjectLink instance) =>
    <String, dynamic>{
      'self': instance.self,
    };

PageLink _$PageLinkFromJson(Map<String, dynamic> json) => PageLink(
      self: json['self'] as String,
      first: json['first'] as String,
      next: json['next'] as String,
      prev: json['prev'] as String,
      last: json['last'] as String,
    );

Map<String, dynamic> _$PageLinkToJson(PageLink instance) => <String, dynamic>{
      'self': instance.self,
      'first': instance.first,
      'next': instance.next,
      'prev': instance.prev,
      'last': instance.last,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: json['user'] as String,
      groupTitle: json['group_title'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionSplit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) {
  final val = <String, dynamic>{
    'created_at': instance.createdAt.toIso8601String(),
    'updated_at': instance.updatedAt.toIso8601String(),
    'user': instance.user,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('group_title', instance.groupTitle);
  val['transactions'] = instance.transactions.map((e) => e.toJson()).toList();
  return val;
}

TransactionSplit _$TransactionSplitFromJson(Map<String, dynamic> json) =>
    TransactionSplit(
      user: json['user'] as String,
      transactionJournalId: json['transaction_journal_id'] as String,
      type: transactionTypePropertyFromJson(json['type']),
      date: DateTime.parse(json['date'] as String),
      order: json['order'] as int?,
      currencyId: json['currency_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      currencySymbol: json['currency_symbol'] as String,
      currencyName: json['currency_name'] as String,
      currencyDecimalPlaces: json['currency_decimal_places'] as int,
      foreignCurrencyId: json['foreign_currency_id'] as String?,
      foreignCurrencyCode: json['foreign_currency_code'] as String?,
      foreignCurrencySymbol: json['foreign_currency_symbol'] as String?,
      foreignCurrencyDecimalPlaces:
          json['foreign_currency_decimal_places'] as int?,
      amount: json['amount'] as String,
      foreignAmount: json['foreign_amount'] as String?,
      description: json['description'] as String,
      sourceId: json['source_id'] as String,
      sourceName: json['source_name'] as String?,
      sourceIban: json['source_iban'] as String?,
      sourceType: accountTypePropertyFromJson(json['source_type']),
      destinationId: json['destination_id'] as String,
      destinationName: json['destination_name'] as String?,
      destinationIban: json['destination_iban'] as String?,
      destinationType: accountTypePropertyFromJson(json['destination_type']),
      budgetId: json['budget_id'] as String?,
      budgetName: json['budget_name'] as String?,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      billId: json['bill_id'] as String?,
      billName: json['bill_name'] as String?,
      reconciled: json['reconciled'] as bool,
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      internalReference: json['internal_reference'] as String?,
      externalId: json['external_id'] as String?,
      externalUrl: json['external_url'] as String?,
      originalSource: json['original_source'] as String?,
      recurrenceId: json['recurrence_id'] as int?,
      recurrenceTotal: json['recurrence_total'] as int?,
      recurrenceCount: json['recurrence_count'] as int?,
      bunqPaymentId: json['bunq_payment_id'] as String?,
      importHashV2: json['import_hash_v2'] as String?,
      sepaCc: json['sepa_cc'] as String?,
      sepaCtOp: json['sepa_ct_op'] as String?,
      sepaCtId: json['sepa_ct_id'] as String?,
      sepaDb: json['sepa_db'] as String?,
      sepaCountry: json['sepa_country'] as String?,
      sepaEp: json['sepa_ep'] as String?,
      sepaCi: json['sepa_ci'] as String?,
      sepaBatchId: json['sepa_batch_id'] as String?,
      interestDate: json['interest_date'] == null
          ? null
          : DateTime.parse(json['interest_date'] as String),
      bookDate: json['book_date'] == null
          ? null
          : DateTime.parse(json['book_date'] as String),
      processDate: json['process_date'] == null
          ? null
          : DateTime.parse(json['process_date'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      paymentDate: json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
      invoiceDate: json['invoice_date'] == null
          ? null
          : DateTime.parse(json['invoice_date'] as String),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      zoomLevel: json['zoom_level'] as int?,
      hasAttachments: json['has_attachments'] as bool,
    );

Map<String, dynamic> _$TransactionSplitToJson(TransactionSplit instance) {
  final val = <String, dynamic>{
    'user': instance.user,
    'transaction_journal_id': instance.transactionJournalId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', transactionTypePropertyToJson(instance.type));
  val['date'] = instance.date.toIso8601String();
  writeNotNull('order', instance.order);
  writeNotNull('currency_id', instance.currencyId);
  writeNotNull('currency_code', instance.currencyCode);
  val['currency_symbol'] = instance.currencySymbol;
  val['currency_name'] = instance.currencyName;
  val['currency_decimal_places'] = instance.currencyDecimalPlaces;
  writeNotNull('foreign_currency_id', instance.foreignCurrencyId);
  writeNotNull('foreign_currency_code', instance.foreignCurrencyCode);
  writeNotNull('foreign_currency_symbol', instance.foreignCurrencySymbol);
  writeNotNull(
      'foreign_currency_decimal_places', instance.foreignCurrencyDecimalPlaces);
  val['amount'] = instance.amount;
  writeNotNull('foreign_amount', instance.foreignAmount);
  val['description'] = instance.description;
  val['source_id'] = instance.sourceId;
  writeNotNull('source_name', instance.sourceName);
  writeNotNull('source_iban', instance.sourceIban);
  writeNotNull('source_type', accountTypePropertyToJson(instance.sourceType));
  val['destination_id'] = instance.destinationId;
  writeNotNull('destination_name', instance.destinationName);
  writeNotNull('destination_iban', instance.destinationIban);
  writeNotNull(
      'destination_type', accountTypePropertyToJson(instance.destinationType));
  writeNotNull('budget_id', instance.budgetId);
  writeNotNull('budget_name', instance.budgetName);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('bill_id', instance.billId);
  writeNotNull('bill_name', instance.billName);
  val['reconciled'] = instance.reconciled;
  writeNotNull('notes', instance.notes);
  writeNotNull('tags', instance.tags);
  writeNotNull('internal_reference', instance.internalReference);
  writeNotNull('external_id', instance.externalId);
  writeNotNull('external_url', instance.externalUrl);
  writeNotNull('original_source', instance.originalSource);
  writeNotNull('recurrence_id', instance.recurrenceId);
  writeNotNull('recurrence_total', instance.recurrenceTotal);
  writeNotNull('recurrence_count', instance.recurrenceCount);
  writeNotNull('bunq_payment_id', instance.bunqPaymentId);
  writeNotNull('import_hash_v2', instance.importHashV2);
  writeNotNull('sepa_cc', instance.sepaCc);
  writeNotNull('sepa_ct_op', instance.sepaCtOp);
  writeNotNull('sepa_ct_id', instance.sepaCtId);
  writeNotNull('sepa_db', instance.sepaDb);
  writeNotNull('sepa_country', instance.sepaCountry);
  writeNotNull('sepa_ep', instance.sepaEp);
  writeNotNull('sepa_ci', instance.sepaCi);
  writeNotNull('sepa_batch_id', instance.sepaBatchId);
  writeNotNull('interest_date', instance.interestDate?.toIso8601String());
  writeNotNull('book_date', instance.bookDate?.toIso8601String());
  writeNotNull('process_date', instance.processDate?.toIso8601String());
  writeNotNull('due_date', instance.dueDate?.toIso8601String());
  writeNotNull('payment_date', instance.paymentDate?.toIso8601String());
  writeNotNull('invoice_date', instance.invoiceDate?.toIso8601String());
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('zoom_level', instance.zoomLevel);
  val['has_attachments'] = instance.hasAttachments;
  return val;
}

BadRequest _$BadRequestFromJson(Map<String, dynamic> json) => BadRequest(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$BadRequestToJson(BadRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

InternalException _$InternalExceptionFromJson(Map<String, dynamic> json) =>
    InternalException(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$InternalExceptionToJson(InternalException instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

NotFound _$NotFoundFromJson(Map<String, dynamic> json) => NotFound(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$NotFoundToJson(NotFound instance) => <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

Unauthenticated _$UnauthenticatedFromJson(Map<String, dynamic> json) =>
    Unauthenticated(
      message: json['message'] as String,
      exception: json['exception'] as String,
    );

Map<String, dynamic> _$UnauthenticatedToJson(Unauthenticated instance) =>
    <String, dynamic>{
      'message': instance.message,
      'exception': instance.exception,
    };

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) =>
    ValidationError(
      message: json['message'] as String,
      errors: ValidationError$Errors.fromJson(
          json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors.toJson(),
    };

Meta$Pagination _$Meta$PaginationFromJson(Map<String, dynamic> json) =>
    Meta$Pagination(
      total: json['total'] as int,
      count: json['count'] as int,
      perPage: json['per_page'] as int,
      currentPage: json['current_page'] as int,
      totalPages: json['total_pages'] as int,
    );

Map<String, dynamic> _$Meta$PaginationToJson(Meta$Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.count,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
    };

ValidationError$Errors _$ValidationError$ErrorsFromJson(
        Map<String, dynamic> json) =>
    ValidationError$Errors(
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      blocked: (json['blocked'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      role:
          (json['role'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      blockedCode: (json['blocked_code'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      name:
          (json['name'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      type:
          (json['type'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      iban:
          (json['iban'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      start:
          (json['start'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      end: (json['end'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      date:
          (json['date'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$ValidationError$ErrorsToJson(
        ValidationError$Errors instance) =>
    <String, dynamic>{
      'email': instance.email,
      'blocked': instance.blocked,
      'role': instance.role,
      'blocked_code': instance.blockedCode,
      'name': instance.name,
      'type': instance.type,
      'iban': instance.iban,
      'start': instance.start,
      'end': instance.end,
      'date': instance.date,
    };
