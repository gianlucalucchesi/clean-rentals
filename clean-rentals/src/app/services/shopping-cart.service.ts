import { Injectable } from '@angular/core';
import { Reservation } from '../models/reservation.model';

@Injectable({
  providedIn: 'root'
})
export class ShoppingCartService {
  reservations: Reservation[] = [];

  constructor() {}

  setReservation(reservation: Reservation) {
    this.reservations.push(reservation);
    console.log(this.reservations);
  }

  validateReservation() {

  }
}
