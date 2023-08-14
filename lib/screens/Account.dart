import 'package:app2/dataAndLogin/AuthService.dart';
import 'package:app2/dataAndLogin/TakePictureScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../dataAndLogin/Userdata.dart';
import '../widgets/SettingsContainer.dart';

class Account extends StatefulWidget {
  final bool loggedIn;

  const Account({super.key, required this.loggedIn});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    final displayName = userData.user?.displayName ?? "No Username";
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(children: [
            Center(
              child: FutureBuilder(
                  future: userData.getProfilePictureURL(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 60,
                        child: ClipOval(
                          child: Image.network(
                            snapshot.data.toString(),
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 60,
                        child: ClipOval(
                          child: Image.network(
                            userData.user?.photoURL ??
                                "https://picsum.photos/200",
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,

                          ),

                          // FadeInImage.assetNetwork(
                          //   image: userData.user!.photoURL??"https://picsum.photos/200",
                          //   fit: BoxFit.cover,
                          //   placeholder: "https://picsum.photos/200",
                          //   width: 200,
                          //   height: 120,
                          // )
                        ),
                      );
                    }
                  }),
            ),
            const SizedBox(height: 15),
            Text(displayName,
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            if (widget.loggedIn)
              SettingsContainer(
                  onTap: () async {
                    // Obtain a list of the available cameras on the device.
                    final cameras = await availableCameras();
                    // Get a specific camera from the list of available cameras.
                    final firstCamera = cameras.first;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TakePictureScreen(
                              camera: firstCamera,
                              setProfilePicture: changeProfilePicture,
                            )));
                  },
                  child: const Text("Change avatar",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500))),
            SettingsContainer(
                onTap: () =>
                {
                  if (widget.loggedIn)
                    AuthService().signOut()
                  else
                    AuthService().signInWithGoogle()
                },
                child: widget.loggedIn
                    ? const Text('SignOut',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500))
                    : const Text('SignIn',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500))),
          ]),
        ),
      ),
    );
  }

  changeProfilePicture(String path) async{
    await userData.changeProfilePicture(path);
    setState(() {

    });
  }
}
