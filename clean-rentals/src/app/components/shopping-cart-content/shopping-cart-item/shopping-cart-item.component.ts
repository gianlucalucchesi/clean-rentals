import { Component, Input, OnInit } from '@angular/core';
import { Reservation } from 'src/app/models/reservation.model';
import { CurrencyService } from 'src/app/services/currency.service';
import { ShoppingCartService } from 'src/app/services/shopping-cart.service';

@Component({
  selector: 'app-shopping-cart-item',
  templateUrl: './shopping-cart-item.component.html',
  styleUrls: ['./shopping-cart-item.component.css'],
})
export class ShoppingCartItemComponent {
  @Input() reservation: Reservation;
  @Input() currency: string;

  constructor(
    private currencyService: CurrencyService,
    private shoppingCartService: ShoppingCartService
  ) {}

  ngOnInit(): void {}

  getUsdPrice(amount: number) {
    return this.currencyService.convertEuroToUsd(amount);
  }

  removeReservation(reservation: Reservation) {
    this.shoppingCartService.removeReservation(reservation);
  }
}
