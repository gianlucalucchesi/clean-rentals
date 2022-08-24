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
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => {},
          ),
          title: Text(
            ('${reservation.car.brand.name} ${reservation.car.model}'),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.green,
              ),
              onPressed: () {}),
          subtitle: Text(
            '\$${reservation.total_price_euro_excl_vat}',
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () => {
            Navigator.of(context).pushNamed(
              ReservationDetailScreen.routeName,
              arguments: reservation.id,
            ),
          },
          child: Image.network(
            reservation.car.image_url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
