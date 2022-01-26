import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';
import { Reservation } from '../models/reservation.model';
import { environment } from '../../environments/environment';
import { ClientService } from './client.service';
import { Client } from '../models/client.model';

@Injectable({
  providedIn: 'root',
})
export class ShoppingCartService {
  reservationObservable$ = new Subject<Reservation[]>();
  reservations: Reservation[] = [];
  client: Client;

  constructor(private http: HttpClient, private clientService: ClientService) {}

  setReservation(reservation: Reservation) {
    this.reservations.push(reservation);
    localStorage.setItem('shopping-cart', JSON.stringify(this.reservations));
    this.reservationObservable$.next(this.reservations);
  }

  validateReservation() {
    //stackoverflow.com/a/42185519/10470183
    https: this.clientService.getClient().then((client: Client) => {
      this.client = client;

      for (let reservation of this.reservations) {
        reservation.client = this.client;
        this.http
          .post(environment.ApiUrl + 'v1/reservation', reservation)
          .subscribe();
      }

      this.reservations = [];
      this.reservationObservable$.next(this.reservations);
      localStorage.removeItem('shopping-cart');
    });
  }
}
