import 'package:e_fashion_flutter/core/utils/assets_manager.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_cubit.dart';
import 'package:e_fashion_flutter/features/home/cubit/home_cubit/home_state.dart';
import 'package:e_fashion_flutter/features/home/screens/widgets/filter/filter_section_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterGenderModel extends Equatable {
  final String title;
  final String image;
  final int id;

  const FilterGenderModel({
    required this.title,
    required this.image,
    required this.id,
  });

  @override
  List<Object?> get props => [title, image, id];
}

class FilterGenderSection extends StatelessWidget {
  const FilterGenderSection({super.key});

  static const List<FilterGenderModel> filterGenderList = [
    FilterGenderModel(title: "women", image: AssetsManager.woman, id: 1),
    FilterGenderModel(title: "men", image: AssetsManager.man, id: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen:
            (previous, current) =>
                previous.genderActiveIndex != current.genderActiveIndex,
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                filterGenderList.length,
                (index) => InkWell(
                  onTap: () {
                    context.read<HomeCubit>().changeGender(index: index);
                    context.read<HomeCubit>().selectGender(
                      gender: filterGenderList[index].id,
                    );
                  },
                  child: Padding(
                    padding:
                        index == 0
                            ? const EdgeInsetsDirectional.only(end: 16.0)
                            : const EdgeInsetsDirectional.only(),
                    child: FilterSectionItem(
                      image: filterGenderList[index].image,
                      text: filterGenderList[index].title,
                      isSelected: state.genderActiveIndex == index,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
