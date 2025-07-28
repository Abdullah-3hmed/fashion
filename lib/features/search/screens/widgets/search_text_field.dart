import 'package:e_fashion_flutter/features/search/bloc/search_bloc.dart';
import 'package:e_fashion_flutter/features/search/bloc/search_events.dart';
import 'package:e_fashion_flutter/features/search/screens/widgets/search_modal_bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        query = value;
        context.read<SearchBloc>().add(SearchProductEvent(query: value));
      },
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        prefixIcon: const Icon(Iconsax.search_normal_1),
        suffixIcon: IconButton(
          onPressed: () async {
            final bloc = context.read<SearchBloc>();
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(32.0),
                  topEnd: Radius.circular(32.0),
                ),
              ),
              builder:
                  (context) => BlocProvider.value(
                    value: bloc,
                    child: SearchModalBottomSheetContent(query: query),
                  ),
            );
          },
          icon: const Icon(Iconsax.filter_search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        hintText: "search",
        hintStyle: Theme.of(context).textTheme.bodySmall,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }
}
