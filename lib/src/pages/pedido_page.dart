// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/pages/update_pedido.dart';

class PedidoPage extends StatelessWidget {
  const PedidoPage({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    final levelIndicator = GFProgressBar(
      width: 120,
      backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
      percentage: double.parse(pedido.estado.toString()),
      progressBarColor: Colors.green,
    );
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        const Icon(
          Icons.airport_shuttle_sharp,
          color: Colors.white,
          size: 40.0,
        ),
        const SizedBox(
          width: 100.0,
          child: Divider(color: Colors.green),
        ),
        const SizedBox(height: 20.0),
        Text(
          pedido.id! + " | HDR: " + pedido.hdr!,
          style: const TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        const SizedBox(height: 30.0),
        levelIndicator,
      ],
    );
    Widget verImg() {
      if (pedido.foto.urlDocumento != "") {
        return Image.network(
          pedido.foto.urlDocumento!,
          height: MediaQuery.of(context).size.height * 0.1,
        );
      } else {
        return const Text("Sin imagen");
      }
    }

    final bottomContentText = Expanded(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Direccion: ",
                style: TextStyle(fontSize: 18.0),
              ),
              Expanded(
                  child: Text(
                pedido.direccion.toString(),
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.normal),
                softWrap: true,
              ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Tipo de servicio: ",
                style: TextStyle(fontSize: 18.0),
              ),
              Text(pedido.tipoServicio.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.normal))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Cliente: ",
                style: TextStyle(fontSize: 18.0),
              ),
              Text(pedido.cliente.nombre.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.normal))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Teléfono: ",
                style: TextStyle(fontSize: 18.0),
              ),
              Text(pedido.cliente.telefono.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.normal))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Cédula: ",
                style: TextStyle(fontSize: 18.0),
              ),
              Text(pedido.cliente.cedula.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.normal))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Observación: ",
                style: TextStyle(fontSize: 18.0),
              ),
              Text(pedido.observacion.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.normal))
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Foto: ",
                  style: TextStyle(fontSize: 18.0),
                ),
                Expanded(
                  child: Column(
                    children: [verImg()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );

    final bottomAction = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GFButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePedido(
                              pedido: pedido,
                              estado: "1",
                            )));
              },
              text: "Confirmar",
              color: Colors.green,
              shape: GFButtonShape.square,
              size: GFSize.LARGE),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GFButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePedido(
                              pedido: pedido,
                              estado: "0.5",
                            )));
              },
              text: "Notificar",
              color: Colors.red,
              shape: GFButtonShape.square,
              size: GFSize.LARGE),
        ),
      ],
    );
    List<Widget> button() {
      if (pedido.estado == "0") {
        return <Widget>[bottomContentText, bottomAction];
      } else {
        return <Widget>[bottomContentText];
      }
    }

    final bottomContent = Expanded(
      child: Column(children: button()),
    );
    final topContent = Stack(
      children: <Widget>[
        Image.network(
          pedido.foto.urlPedido!,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.only(top: 40, left: 65),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 50.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 40,
            ),
          ),
        )
      ],
    );
    return Scaffold(
        body: Column(
      children: <Widget>[topContent, bottomContent],
    ));
  }
}
