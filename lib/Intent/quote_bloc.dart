import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_bloc_api_demo/Intent/quote_event.dart';
import 'package:test_bloc_api_demo/Intent/quote_state.dart';

// BLoC class for handling state management related to fetching and displaying quotes
class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  // Constructor initializes the QuoteBloc with the initial state and sets up event handling
  QuoteBloc() : super(InitialQuoteState()) {
    on<FetchQuote>(_fetchQuote);
  }

  // Private method for handling the FetchQuote event and updating the state accordingly
  _fetchQuote(QuoteEvent event, Emitter<QuoteState> emit) async {
    // Checking if the event is of type FetchQuote
    if (event is FetchQuote) {
      // Emitting a loading state to indicate that the quote is being fetched
      emit(QuoteLoading());
      try {
        // Making an HTTP GET request to the quotable.io API to fetch a random quote
        final response =
            await http.get(Uri.parse('https://api.quotable.io/random'));

        // Checking if the response status code is OK (200)
        if (response.statusCode == 200) {
          // Decoding the JSON response and creating a QuoteLoaded state with the retrieved data
          final data = json.decode(response.body);
          final quote = QuoteLoaded(
            content: data['content'],
            author: data['author'],
            tags: List<String>.from(data['tags']),
            dateAdded: data['dateAdded'],
          );

          // Emitting the QuoteLoaded state to update the UI with the fetched quote
          emit(quote);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(QuoteError('Failed to load quote'));
        }
      } catch (exception) {
        // Emitting an error state if an exception occurs during the fetching process
        emit(QuoteError('Error: $exception'));
      }
    }
  }
}
