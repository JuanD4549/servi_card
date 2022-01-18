import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servi_card/src/models/pedido_model.dart';

class UpdatePedido extends StatefulWidget {
  const UpdatePedido({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;
  @override
  _UpdatePedidoState createState() => _UpdatePedidoState();
}

class _UpdatePedidoState extends State<UpdatePedido> {
  final observacion = TextEditingController();
  File? sampleImage;
  get picker => null;
  @override
  Widget build(BuildContext context) {
    String? obsValidation(String? value) {
      if (value!.isEmpty) {
        return "Dirección requerida";
      }
      return null;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Confirmado"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            sampleImage == null
                ? const Text("Select an Image")
                : enableUpload(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 15,
                  child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(children: <Widget>[
                        TextFormField(
                            controller: observacion,
                            decoration: const InputDecoration(
                                labelText: "Observación",
                                prefixIcon: Icon(Icons.announcement_outlined)),
                            validator: obsValidation),
                      ]))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: getImage,
                tooltip: "Add Image",
                child: const Icon(Icons.add_a_photo),
              ),
            ),
            GFButton(
                onPressed: () async {
                  await _sendToServer();
                  await _sendToServerImg();
                  Navigator.of(context).pop();
                },
                text: "Enviar",
                color: Colors.green,
                shape: GFButtonShape.square,
                size: GFSize.LARGE)
          ],
        ));
  }

  Future getImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    var tempImage = await ImagePicker.platform.getImage(
        source: ImageSource.gallery,
        maxWidth: null,
        maxHeight: null,
        imageQuality: null,
        preferredCameraDevice: CameraDevice.front);

    setState(() {
      try {
        sampleImage = File(tempImage!.path);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
  }

  enableUpload() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Image.file(
          sampleImage!,
          height: 300.0,
          width: 600.0,
        ),
      ],
    ));
  }

  Future<void> _sendToServerImg() async {
    final Reference firebasesStorageRef =
        FirebaseStorage.instance.ref().child(sampleImage!.path);
    final UploadTask task = firebasesStorageRef.putFile(sampleImage!);
  }

  Future<void> _sendToServer() async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('pedido');
      QuerySnapshot pd = await reference.get();
      for (var doc in pd.docs) {
        if (widget.pedido.id == doc.get("id").toString()) {
          await reference.doc(doc.id).update({"observacion": observacion.text});
        }
      }
    });
  }
}
