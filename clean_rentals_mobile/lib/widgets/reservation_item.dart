import 'package:clean_rentals_mobile/screens/reservation_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reservation.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservation = Provider.of<Reservation>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black54,
          height: 50,
          child: GridTileBar(
            title: Text(
              ('${reservation.car.brand.name} ${reservation.car.model}'),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              '€${reservation.total_price_euro_excl_vat}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => {
            Navigator.of(context).pushNamed(
              ReservationDetailScreen.routeName,
              arguments: reservation.id,
            ),
          },
          child: Image(
            image: AssetImage(reservation.car.image_url),
          ),
        ),
      ),
    );
  }
}
