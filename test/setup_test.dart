import 'package:space_traders/infra-ui/adapters.dart';

import 'mocks/server.inMemory.dart';

void main() {
  // Register all inMemory Adapters
  Adapters.saveTokenAdapter = (token) {};
  Adapters.serverAdapter = ServerInMemoryAdapter();
}
