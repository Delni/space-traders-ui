class Entity {
  final String symbol;

  Entity({required this.symbol});
}

bool Function(Entity) hasSymbol(String symbol) =>
    (element) => element.symbol == symbol;
