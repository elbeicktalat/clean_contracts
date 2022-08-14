/// The part of all DataSources, like Remote and Local.
///
/// It contains the actual implementation of the data source.
abstract class DataSource {}

/// The concrete Local DataSource,
/// its responsibility deal with device storage, to may cache data.
abstract class LocalDataSource extends DataSource {}

/// The concrete Remote DataSource, its responsibility deal with the APIs.
abstract class RemoteDataSource extends DataSource {}
