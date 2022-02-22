// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:servi_card/src/models/pedido_model.dart';
import 'package:servi_card/src/pages/update_pedido.dart';
import 'package:servi_card/src/widgets/map_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  void lauchWhatsapp(Pedido pedido) async {
    String numero = "+593" + pedido.cliente.telefono!;
    String url = "whatsapp://send?phone=$numero&text=" "";
    await canLaunch(url) ? launch(url) : print("No se pudo abrir whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    final levelIndicator = GFProgressBar(
      width: 120,
      backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
      percentage: double.parse(widget.pedido.estado.toString()),
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
          widget.pedido.id! + " | HDR: " + widget.pedido.hdr!,
          style: const TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        const SizedBox(height: 30.0),
        levelIndicator,
      ],
    );
    Widget verImg() {
      if (widget.pedido.foto.urlDocumento != "") {
        return Image.network(
          widget.pedido.foto.urlDocumento!,
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
                widget.pedido.direccion.toString(),
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
              Text(widget.pedido.tipoServicio.toString(),
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
              Text(widget.pedido.cliente.nombre.toString(),
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
              TextButton.icon(
                onPressed: () {
                  lauchWhatsapp(widget.pedido);
                },
                label: Text(widget.pedido.cliente.telefono.toString(),
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.normal)),
                icon: const Icon(Icons.phone_android),
              ),
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
              Text(widget.pedido.cliente.cedula.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.normal))
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MapWidget(pedido: widget.pedido),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Text(
                "Observación: ",
                style: TextStyle(fontSize: 18.0),
              ),
              Text(widget.pedido.observacion.toString(),
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
                              pedido: widget.pedido,
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
                              pedido: widget.pedido,
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
      if (widget.pedido.estado == "0") {
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
          widget.pedido.foto.urlPedido!,
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
