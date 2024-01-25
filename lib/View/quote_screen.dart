import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc_api_demo/Intent/quote_bloc.dart';
import 'package:test_bloc_api_demo/Intent/quote_event.dart';
import 'package:test_bloc_api_demo/Intent/quote_state.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key, required this.title});
  final String title;

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  @override
  Widget build(BuildContext context) {
    final quoteBloc = BlocProvider.of<QuoteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Text(
          widget.title,
        ),
      ),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is InitialQuoteState) {
            return const Center(child: Text('Press referesh to load quotes'));
          } else if (state is QuoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuoteLoaded) {
            return QuoteDetails(quote: state);
          } else if (state is QuoteError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          quoteBloc.add(FetchQuote());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class QuoteDetails extends StatelessWidget {
  final QuoteLoaded quote;

  QuoteDetails({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Content:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                quote.content,
                style: const TextStyle(fontSize: 18),
              ),
              const Divider(),
              const Text(
                'Author:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                quote.author,
                style: const TextStyle(fontSize: 18),
              ),
              const Divider(),
              const Text(
                'Tags:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                quote.tags.join(', '),
                style: const TextStyle(fontSize: 18),
              ),
              const Divider(),
              const Text(
                'Date Added:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                quote.dateAdded,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
