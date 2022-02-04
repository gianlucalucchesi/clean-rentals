import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription, take } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { CurrencyService } from 'src/app/services/currency.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-detail',
  templateUrl: './reservation-detail.component.html',
  styleUrls: ['./reservation-detail.component.css'],
})
export class ReservationDetailComponent implements OnInit, OnDestroy {
  reservationId: string;
  currentReservationId$: Subscription;
  reservation: Reservation;
  currencySubscription$: Subscription;
  currency: string;

  constructor(
    private reservationService: ReservationService,
    private route: ActivatedRoute,
    private currencyService: CurrencyService
  ) {
    this.currency = this.currencyService.getCurrency();
  }

  ngOnInit(): void {
    // https://angular-training-guide.rangle.io/routing/child_routes
    this.route.params.pipe(take(1)).subscribe((params) => {
      this.reservationService.getReservationItem$(params['id']).subscribe({
        next: (reservation) => (this.reservation = reservation),
      });
    });

    this.currencySubscription$ =
      this.currencyService.currencyChanged$.subscribe({
        next: (currency) => (this.currency = currency),
      });
  }

  ngOnDestroy(): void {
    this.currencySubscription$.unsubscribe();
  }

  getUsdPrice(): number {
    return this.currencyService.convertEuroToUsd(
      this.reservation.total_price_euro_excl_vat
    );
  }
}
