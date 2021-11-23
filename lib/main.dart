import 'package:clean_arch/core/database/init_database.dart';
import 'package:clean_arch/features/album/presentation/mobx/album_state.dart';
import 'package:clean_arch/features/album/presentation/mobx/album_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final albumStore = GetIt.I.get<AlbumStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Clean'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<AlbumState>(
            future: albumStore.getAlbums(),
            builder: (context, snapshot) {
              if (snapshot.data is LoadingState) {
                return const CircularProgressIndicator();
              } else if (snapshot.data is LoadedSucessState) {
                final albums = (snapshot.data as LoadedSucessState);
                return Expanded(
                  child: ListView.builder(
                    itemCount: albums.album.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(albums.album[index].title.toString()),
                      );
                    },
                  ),
                );
              } else if (snapshot.data is ErrorState) {
                return const Text("Erro");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   //StreamSubscription<DataConnectionStatus> listener;
//   var internetStatus = "Unknown";

//   @override
//   void initState() {
//     super.initState();
//     CheckInternet();
//     //BlocProvider.of<AlbumBloc>(context).add(LoadingSucessAlbumEvent());
//   }

//   // @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   //listener.cancel();
//   //   super.dispose();
//   // }

//   CheckInternet() async {
//     // Simple check to see if we have internet
//     debugPrint("The statement 'this machine is connected to the Internet' is: ");
//     //debugPrint(await DataConnectionChecker().hasConnection);
//     // returns a bool

//     // We can also get an enum instead of a bool
//     //print("Current status: ${await DataConnectionChecker().connectionStatus}");
//     // prints either DataConnectionStatus.connected
//     // or DataConnectionStatus.disconnected

//     // This returns the last results from the last call
//     // to either hasConnection or connectionStatus
//     //print("Last results: ${DataConnectionChecker().lastTryResults}");

//     // actively listen for status updates
//     // listener = DataConnectionChecker().onStatusChange.listen((status) {
//     //   switch (status) {
//     //     case DataConnectionStatus.connected:
//     //       Internetstatus = "Connected to the internet";
//     //       print('Data connection is available.');
//     //       setState(() {});
//     //       break;
//     //     case DataConnectionStatus.disconnected:
//     //       Internetstatus = "No Data Connection";
//     //       print('You are disconnected from the internet.');
//     //       setState(() {});
//     //       break;
//     //   }
//     // });

//     // close listener after 30 seconds, so the program doesn't run forever
// //    await Future.delayed(Duration(seconds: 30));
// //    await listener.cancel();
//     return await DataConnectionChecker().connectionStatus;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: BlocListener<AlbumBloc, AlbumState>(
//           listener: (context, state) {
//             if (state is ErrorState) {
//               Scaffold.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                 ),
//               );
//             }
//           },
//           child: _blocBuilder(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         elevation: 10,
//         onPressed: () => _modalAdd(context: context),
//       ),
//     );
//   }

//   _blocBuilder() {
//     return BlocBuilder<AlbumBloc, AlbumState>(
//       builder: (context, state) {
//         if (state is InitialState) {
//           return Center(
//             child: Text("Initial"),
//           );
//         } else if (state is LoadingState) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is LoadedSucessState) {
//           return Column(
//             children: <Widget>[
//               Text(
//                 "$Internetstatus",
//                 style: TextStyle(
//                     backgroundColor: Colors.black,
//                     color: Colors.white,
//                     fontSize: 20),
//               ),
//               Text("Total Albums:${state.album.length}"),
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: state.album.length,
//                   itemBuilder: (context, index) {
//                     return Dismissible(
//                       key: UniqueKey(),
//                       background: Container(
//                         color: Colors.blue,
//                       ),
//                       child: ListTile(
//                         title: Text(state.album[index].title),
//                         trailing: Wrap(
//                           children: <Widget>[
//                             IconButton(
//                               icon: Icon(
//                                 Icons.edit,
//                                 color: Colors.deepPurple,
//                               ),
//                               onPressed: () => _modalUpdate(
//                                 album: state.album[index],
//                                 context: context,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       onDismissed: (DismissDirection direction) {
//                         BlocProvider.of<AlbumBloc>(context)
//                             .add(DeleteAlbumEvent(state.album[index]));

//                         // Then show a snackbar.
//                         Scaffold.of(context)
//                             .showSnackBar(SnackBar(content: Text("dismissed")));
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         } else if (state is ErrorState) {
//           return Center(child: Text("Error"));
//         }
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'nothing data :(',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// _modalAdd({BuildContext context}) {
//   String _title;
//   showDialog(
//       barrierDismissible: true,
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Text('Adicionar'),
//           content: Wrap(
//             children: <Widget>[
//               TextFormField(
//                 onChanged: (newTitle) => _title = newTitle,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'title...',
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             FlatButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancelar'),
//             ),
//             FlatButton(
//               onPressed: () {
//                 BlocProvider.of<AlbumBloc>(context)
//                     .add(CreateAlbumEvent(AlbumModel(title: _title)));

//                 Navigator.pop(context);
//               },
//               child: Text('Adicionar'),
//             ),
//           ],
//         );
//       });
// }

// _modalUpdate({AlbumModel album, BuildContext context}) {
//   var _title = album.title;
//   showDialog(
//       barrierDismissible: true,
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Text("Alterar"),
//           content: Wrap(
//             children: <Widget>[
//               TextFormField(
//                 initialValue: album.title,
//                 onChanged: (newTitle) => _title = newTitle,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'title',
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             FlatButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancelar'),
//             ),
//             FlatButton(
//               onPressed: () {
//                 BlocProvider.of<AlbumBloc>(context)
//                     .add(UpdateAlbumEvent(AlbumModel(
//                   title: _title,
//                   id: album.id,
//                   userId: album.userId,
//                 )));
//                 Navigator.pop(context);
//               },
//               child: Text('Alterar'),
//             ),
//           ],
//         );
//       });
// }
