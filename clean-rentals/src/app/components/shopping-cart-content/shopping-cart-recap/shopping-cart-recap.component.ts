import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { CurrencyService } from 'src/app/services/currency.service';
import { ShoppingCartService } from 'src/app/services/shopping-cart.service';
@Component({
  selector: 'app-shopping-cart-recap',
  templateUrl: './shopping-cart-recap.component.html',
  styleUrls: ['./shopping-cart-recap.component.css']
})
export class ShoppingCartRecapComponent implements OnInit, OnDestroy {
  reservationsChanged: Subscription;
  reservations: Reservation[] = [];
  totalExclTax = 0;
  vat = 0;
  @Input() currency: string;

  constructor(
    private shoppingCartService: ShoppingCartService,
    private currencyService: CurrencyService
  ) {
    if(localStorage.getItem('shopping-cart')) {
      this.reservations = <Reservation[]>JSON.parse(localStorage.getItem('shopping-cart'));
    } else {
      this.reservations = this.shoppingCartService.reservations;
    }

    this.currency = this.currencyService.getCurrency();
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
  }

  ngOnDestroy(): void {
    this.reservationsChanged.unsubscribe();
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
