// QuoteEvent classes
// Abstract base class for defining quote-related events
abstract class QuoteEvent {}

// Event class for triggering the fetching of a new quote
class FetchQuote extends QuoteEvent {}
