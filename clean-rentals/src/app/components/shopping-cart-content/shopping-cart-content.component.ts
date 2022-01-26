import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { CurrencyService } from 'src/app/services/currency.service';
import { ShoppingCartService } from 'src/app/services/shopping-cart.service';

@Component({
  selector: 'app-shopping-cart-content',
  templateUrl: './shopping-cart-content.component.html',
  styleUrls: ['./shopping-cart-content.component.css'],
})
export class ShoppingCartContentComponent implements OnInit, OnDestroy {
  reservationsChanged: Subscription;
  reservations: Reservation[] = [];
  totalExclTax = 0;
  vat = 0;
  currency;
  currencyChanged: Subscription;

  constructor(
    private shoppingCartService: ShoppingCartService,
    private currencyService: CurrencyService
  ) {
    this.currency = this.currencyService.getCurrency();
    this.reservations = this.shoppingCartService.reservations;
    this.getTotals();
  }

  ngOnInit(): void {
    this.reservationsChanged =
      this.shoppingCartService.reservationObservable$.subscribe({
        next: (reservations) => {
          this.reservations = reservations;
          this.getTotals();
        },
      });

    this.currencyChanged = this.currencyService.currencyChanged$.subscribe({
      next: (currency) => this.currency = currency
    })

  }

  ngOnDestroy(): void {
    this.reservationsChanged.unsubscribe();
    this.currencyChanged.unsubscribe();
  }

  getTotals() {
    for (let reservation of this.reservations) {
      this.totalExclTax += reservation.total_price_euro_excl_vat;
    }

    this.vat = this.totalExclTax * 0.21;
  }

  getUsdPrice(amount: number) {
    return this.currencyService.convertEuroToUsd(amount);
  }

  submit() {
    this.shoppingCartService.validateReservation();
  }
}
