sealed class ItemPickState {}

class ItemPickError extends ItemPickState {
  final String message;
  final Object? error;

  ItemPickError({required this.message, this.error});
}

class ItemPickInitial extends ItemPickState {}

class PickingItem extends ItemPickState {}

class WaitingItemTake extends ItemPickState {}
