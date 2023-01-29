import 'package:flutter/material.dart';

class RoomSetup extends StatefulWidget {
  final Image img;
  const RoomSetup({Key? key, required this.img}) : super(key: key);

  @override
  State<RoomSetup> createState() => _RoomSetupState();
}

class _RoomSetupState extends State<RoomSetup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 38),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1,
                child: widget.img,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                label: const Text('Room Name')
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextButton(
                onPressed: () async {

                },
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.purpleAccent),
                    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Colors.purpleAccent,
                              width: 3,
                            )
                        )
                    )
                ),
                child: Row(
                  children: const [
                    Spacer(),
                    Text(
                      'Add Room',
                      style: TextStyle(
                          color: Colors.purpleAccent
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
