import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:path/path.dart';
import 'package:servi_card/src/models/pedido_model.dart';

class UpdatePedido extends StatefulWidget {
  const UpdatePedido({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;
  @override
  _UpdatePedidoState createState() => _UpdatePedidoState();
}

class _UpdatePedidoState extends State<UpdatePedido> {
  final observacion = TextEditingController();
  final CameraDescription camera = const CameraDescription(
      name: "Equipo",
      lensDirection: CameraLensDirection.back,
      sensorOrientation: 0);
  final cameras = availableCameras();
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                child: const Icon(Icons.camera_alt),
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    final path = join('assets', 'img', '${DateTime.now()}.png');
                    XFile picture = await _controller.takePicture();
                    picture.saveTo(path);
                  } catch (e) {
                    // Si se produce un error, regístralo en la consola.
                    // ignore: avoid_print
                    print(e);
                  }
                },
              ),
            ),
            GFButton(
                onPressed: () async {
                  await _sendToServer();
                  Navigator.of(context).pop();
                },
                text: "Enviar",
                color: Colors.green,
                shape: GFButtonShape.square,
                size: GFSize.LARGE)
          ],
        ));
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
