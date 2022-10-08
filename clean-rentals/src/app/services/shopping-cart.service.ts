import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';
import { Reservation } from '../models/reservation.model';
import { environment } from '../../environments/environment';
import { ClientService } from './client.service';
import { Client } from '../models/client.model';
import * as uuid from 'uuid';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class ShoppingCartService {
  //************* PayPal sandbox account *************//
  // email: sb-fmkgp12805364@personal.example.com
  // pwd: 9q#d*HN=

  reservationListChanged$ = new Subject<Reservation[]>();
  reservationList: Reservation[] = [];
  client: Client;
  checkoutSuccess = false;
  checkoutStatusChanged$ = new Subject<boolean>();
  checkoutFailed = false;
  checkoutFailedChanged$ = new Subject<boolean>();
  reservationFailed = false;
  reservationFailedChanged$ = new Subject<boolean>();
  reservationSuccess = false;
  reservationSuccessChanged$ = new Subject<boolean>();

  constructor(
    private http: HttpClient,
    private clientService: ClientService,
    private router: Router
  ) {}

  setReservation(reservation: Reservation) {
    this.reservationList.push(reservation);
    localStorage.setItem('shopping-cart', JSON.stringify(this.reservationList));
    this.reservationListChanged$.next(this.reservationList);
    this.router.navigate(['/cars-overview']);
  }

  removeReservation(reservation: Reservation) {
    let removeReservationSuccess = true;

    this.http
      .patch(
        environment.ApiUrl + 'v1/reservation/cancel/' + reservation.id,
        null
      )
      .subscribe({
        next: () => {
          const index = this.reservationList.findIndex(
            (x) => x.id === reservation.id
          );
          this.reservationList.splice(index, 1);
          localStorage.setItem(
            'shopping-cart',
            JSON.stringify(this.reservationList)
          );
          this.reservationListChanged$.next(this.reservationList);
        },
        error: () => (removeReservationSuccess = false),
      });
  }

  checkoutShoppingCart() {
    //stackoverflow.com/a/42185519/10470183
    for (let reservation of this.reservationList) {
      this.http
        .patch(
          environment.ApiUrl + 'v1/reservation/paid/' + reservation.id,
          null
        )
        .subscribe({
          next: () => null,
          error: () => this.checkoutFailedChanged(true),
        });
    }

    this.reservationList = [];
    this.reservationListChanged$.next(this.reservationList);
    localStorage.removeItem('shopping-cart');
    this.checkoutSuccess = true;
    this.checkoutStatusChanged$.next(this.checkoutSuccess);
  }

  validateReservation(reservation: Reservation) {
    this.clientService.getClient().then((client: Client) => {
      reservation.id = uuid.v4();
      reservation.client = client;

      this.http
        .post(environment.ApiUrl + 'v1/reservation', reservation)
        .subscribe({
          next: () => {
            this.setReservation(reservation);
            this.changeReservationSuccess(true);
          },
          error: () => {
            this.changeReservationFailed(true);
          },
        });
    });
  }

  changeCheckoutState(value: boolean) {
    this.checkoutSuccess = value;
    this.checkoutStatusChanged$.next(this.checkoutSuccess);
  }

  checkoutFailedChanged(value: boolean) {
    this.checkoutFailed = value;
    this.checkoutFailedChanged$.next(this.checkoutFailed);
  }

  changeReservationFailed(value: boolean) {
    this.reservationFailed = value;
    this.reservationSuccess = !value;
    this.reservationFailedChanged$.next(this.reservationFailed);
    this.reservationSuccessChanged$.next(this.reservationSuccess);
  }

  changeReservationSuccess(value: boolean) {
    this.reservationSuccess = value;
    this.reservationFailed = !value;
    this.reservationSuccessChanged$.next(this.reservationSuccess);
    this.reservationFailedChanged$.next(this.reservationFailed);
  }
}
