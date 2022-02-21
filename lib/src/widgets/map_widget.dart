import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servi_card/src/models/pedido_model.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.pedido}) : super(key: key);
  final Pedido pedido;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    final CameraPosition camara = CameraPosition(
        zoom: 17.5,
        target: LatLng(double.parse(widget.pedido.lat!),
            double.parse(widget.pedido.log!)));
    final Set<Marker> points = <Marker>{
      Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(235),
          infoWindow: InfoWindow(
              title: widget.pedido.cliente.nombre,
              snippet: widget.pedido.cliente.telefono),
          position: LatLng(double.parse(widget.pedido.lat!),
              double.parse(widget.pedido.log!)),
          markerId: MarkerId(widget.pedido.cliente.nombre!))
    };
    return GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controler) {
          _controller.complete(controler);
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: points,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        initialCameraPosition: camara);
  }
}
