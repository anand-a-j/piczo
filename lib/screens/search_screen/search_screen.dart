import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piczo/providers/loading_provider.dart';
import 'package:piczo/screens/profile_screen/profile_screen.dart';
import 'package:piczo/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadingProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search,color: kWhite,),
              hintText: "Search users here",
              hintStyle: const TextStyle(color: kGrey),
              filled: true,
              fillColor: kBlack.withOpacity(0.7),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: kGrey),
            onFieldSubmitted: (String _) {
              provider.changeIsLoading = true;
            }),
      ),
      body: _searchController.text != '' &&
              Provider.of<LoadingProvider>(context, listen: true).isLoading ==
                  true
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text.trim())
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data as dynamic).docs.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                uid: (snapshot.data! as dynamic).docs[index]
                                    ['uid']),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl']),
                        ),
                        title: Text(
                            (snapshot.data! as dynamic).docs[index]['username'],
                            style: const TextStyle(color: kWhite)),
                      ),
                    );
                  }),
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                   return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null||snapshot.connectionState==ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MasonryGridView.count(
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    itemCount: (snapshot.data as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                          (snapshot.data! as dynamic).docs[index]['postUrl']);
                    });
              },
            ),
    );
  }
}

TextEditingController _searchController = TextEditingController();
