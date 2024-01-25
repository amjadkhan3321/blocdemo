// QuoteState classes
// Abstract base class for defining quote-related states
abstract class QuoteState {}

// Subclass representing the initial state.
class InitialQuoteState extends QuoteState {}

// State class indicating that a quote is currently being fetched
class QuoteLoading extends QuoteState {}

// State class representing a successfully loaded quote with content, author, tags, and date added
class QuoteLoaded extends QuoteState {
  final String content;
  final String author;
  final List<String> tags;
  final String dateAdded;

  // Constructor for creating a QuoteLoaded instance with required data
  QuoteLoaded({
    required this.content,
    required this.author,
    required this.tags,
    required this.dateAdded,
  });
}

// State class representing an error in the quote fetching process with an error message
class QuoteError extends QuoteState {
  final String errorMessage;

  // Constructor for creating a QuoteError instance with the provided error message
  QuoteError(this.errorMessage);
}
