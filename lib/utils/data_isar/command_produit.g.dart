// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_produit.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetCommandProduitCollection on Isar {
  IsarCollection<CommandProduit> get commandProduits => this.collection();
}

const CommandProduitSchema = CollectionSchema(
  name: r'CommandProduit',
  id: 7207103901927001440,
  properties: {
    r'createdAtComProd': PropertySchema(
      id: 0,
      name: r'createdAtComProd',
      type: IsarType.dateTime,
    ),
    r'price': PropertySchema(
      id: 1,
      name: r'price',
      type: IsarType.long,
    )
  },
  estimateSize: _commandProduitEstimateSize,
  serialize: _commandProduitSerialize,
  deserialize: _commandProduitDeserialize,
  deserializeProp: _commandProduitDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'products': LinkSchema(
      id: -7767811640051481073,
      name: r'products',
      target: r'Product',
      single: true,
    ),
    r'commands': LinkSchema(
      id: 6344048578804693335,
      name: r'commands',
      target: r'Command',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _commandProduitGetId,
  getLinks: _commandProduitGetLinks,
  attach: _commandProduitAttach,
  version: '3.0.5',
);

int _commandProduitEstimateSize(
  CommandProduit object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _commandProduitSerialize(
  CommandProduit object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAtComProd);
  writer.writeLong(offsets[1], object.price);
}

CommandProduit _commandProduitDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CommandProduit();
  object.createdAtComProd = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.price = reader.readLongOrNull(offsets[1]);
  return object;
}

P _commandProduitDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _commandProduitGetId(CommandProduit object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _commandProduitGetLinks(CommandProduit object) {
  return [object.products, object.commands];
}

void _commandProduitAttach(
    IsarCollection<dynamic> col, Id id, CommandProduit object) {
  object.id = id;
  object.products.attach(col, col.isar.collection<Product>(), r'products', id);
  object.commands.attach(col, col.isar.collection<Command>(), r'commands', id);
}

extension CommandProduitQueryWhereSort
    on QueryBuilder<CommandProduit, CommandProduit, QWhere> {
  QueryBuilder<CommandProduit, CommandProduit, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CommandProduitQueryWhere
    on QueryBuilder<CommandProduit, CommandProduit, QWhereClause> {
  QueryBuilder<CommandProduit, CommandProduit, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CommandProduitQueryFilter
    on QueryBuilder<CommandProduit, CommandProduit, QFilterCondition> {
  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      createdAtComProdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtComProd',
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      createdAtComProdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtComProd',
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      createdAtComProdEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtComProd',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      createdAtComProdGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtComProd',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      createdAtComProdLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtComProd',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      createdAtComProdBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtComProd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      priceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      priceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      priceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      priceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CommandProduitQueryObject
    on QueryBuilder<CommandProduit, CommandProduit, QFilterCondition> {}

extension CommandProduitQueryLinks
    on QueryBuilder<CommandProduit, CommandProduit, QFilterCondition> {
  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition> products(
      FilterQuery<Product> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'products');
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      productsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'products', 0, true, 0, true);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition> commands(
      FilterQuery<Command> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'commands');
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterFilterCondition>
      commandsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'commands', 0, true, 0, true);
    });
  }
}

extension CommandProduitQuerySortBy
    on QueryBuilder<CommandProduit, CommandProduit, QSortBy> {
  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy>
      sortByCreatedAtComProd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtComProd', Sort.asc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy>
      sortByCreatedAtComProdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtComProd', Sort.desc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }
}

extension CommandProduitQuerySortThenBy
    on QueryBuilder<CommandProduit, CommandProduit, QSortThenBy> {
  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy>
      thenByCreatedAtComProd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtComProd', Sort.asc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy>
      thenByCreatedAtComProdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtComProd', Sort.desc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }
}

extension CommandProduitQueryWhereDistinct
    on QueryBuilder<CommandProduit, CommandProduit, QDistinct> {
  QueryBuilder<CommandProduit, CommandProduit, QDistinct>
      distinctByCreatedAtComProd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtComProd');
    });
  }

  QueryBuilder<CommandProduit, CommandProduit, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }
}

extension CommandProduitQueryProperty
    on QueryBuilder<CommandProduit, CommandProduit, QQueryProperty> {
  QueryBuilder<CommandProduit, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CommandProduit, DateTime?, QQueryOperations>
      createdAtComProdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtComProd');
    });
  }

  QueryBuilder<CommandProduit, int?, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }
}
