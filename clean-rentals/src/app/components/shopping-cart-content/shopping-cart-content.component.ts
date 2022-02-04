import { Component, OnDestroy, OnInit, Output } from '@angular/core';
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
  currencyChanged: Subscription;
  @Output() currency: string;
  checkoutSuccess = false;
  checkoutStatusChanged: Subscription;

  constructor(
    private shoppingCartService: ShoppingCartService,
    private currencyService: CurrencyService
  ) {
    if (localStorage.getItem('shopping-cart')) {
      this.reservations = <Reservation[]>(
        JSON.parse(localStorage.getItem('shopping-cart'))
      );
      this.shoppingCartService.reservations = this.reservations;
    } else {
      this.reservations = this.shoppingCartService.reservations;
    }

    this.currency = this.currencyService.getCurrency();
  }

  ngOnInit(): void {
    this.reservationsChanged =
      this.shoppingCartService.reservationChanged$.subscribe({
        next: (reservations) => (this.reservations = reservations),
      });

    this.currencyChanged = this.currencyService.currencyChanged$.subscribe({
      next: (currency) => (this.currency = currency),
    });

    this.checkoutStatusChanged =
      this.shoppingCartService.checkoutStatusChanged$.subscribe({
        next: (checkoutSuccess) => (this.checkoutSuccess = checkoutSuccess),
      });
  }

  ngOnDestroy(): void {
    this.reservationsChanged.unsubscribe();
    this.currencyChanged.unsubscribe();
    this.checkoutStatusChanged.unsubscribe();
  }
}
