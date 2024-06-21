abstract interface class ORMInterface<T> {
  Future<List<T>> query(bool Function(T) filter);
  Future<void> insert(T model);
  Future<void> delete(bool Function(T) filter);
  Future<void> update(bool Function(T) filter, T Function(T) updateFields);
}
