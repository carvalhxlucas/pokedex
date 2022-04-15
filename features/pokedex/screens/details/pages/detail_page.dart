import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/common/models/pokemon.dart';
import 'package:flutter_pokedex/features/pokedex/screens/details/pages/widgets/detail_app_bar_widget.dart';
import 'package:flutter_pokedex/features/pokedex/screens/details/pages/widgets/detail_list_widget.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    Key? key,
    required this.pokemon,
    required this.list,
    required this.onBack,
    required this.controller,
    required this.onChangePokemon,
  }) : super(key: key);
  final Pokemon pokemon;
  final List<Pokemon> list;
  final VoidCallback onBack;
  final PageController controller;
  final ValueChanged<Pokemon> onChangePokemon;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ScrollController scrollController;

  @override
  void initState(){
    super.initState();
    scrollController = ScrollController();
  }

  bool isOnTop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          setState(() {
            if(scrollController.position.pixels > 37){
              isOnTop = false;
            } else if (scrollController.position.pixels == 0) {
              isOnTop = true;
            }
          });
          return false;
        },
        child: CustomScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          slivers: [
            DetailAppBarWidget(
              pokemon: widget.pokemon,
              onBack: widget.onBack,
              isOnTop: isOnTop,
            ),
            DetailListWidget(
                pokemon: widget.pokemon,
                list: widget.list,
                controller: widget.controller,
                onChangePokemon: widget.onChangePokemon
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      color: widget.pokemon.baseColor
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
        ),
      )


      /*Stack(
        children: [
          DetailAppBarWidget(
            pokemon: pokemon,
            onBack: onBack,
          ),
          DetailListWidget(
              pokemon: pokemon,
              list: list,
              controller: controller,
              onChangePokemon: onChangePokemon
          )
        ],
      )*/,
    );
  }
}
