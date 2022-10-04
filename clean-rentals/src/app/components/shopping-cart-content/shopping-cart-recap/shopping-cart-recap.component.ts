import {
  AfterViewChecked,
  Component,
  Input,
  OnChanges,
  OnDestroy,
  OnInit,
} from '@angular/core';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { CurrencyService } from 'src/app/services/currency.service';
import { ShoppingCartService } from 'src/app/services/shopping-cart.service';
import { environment as env } from '../../../../environments/environment';

declare let paypal: any;

/*
PayPal sandbox email: sb-fmkgp12805364@personal.example.com
PayPal sandbox psw: 9q#d*HN=
*/

@Component({
  selector: 'app-shopping-cart-recap',
  templateUrl: './shopping-cart-recap.component.html',
  styleUrls: ['./shopping-cart-recap.component.css'],
})
export class ShoppingCartRecapComponent
  implements OnInit, OnChanges, OnDestroy, AfterViewChecked
{
  reservationsChanged: Subscription;
  reservations: Reservation[] = [];
  totalExclTax: number = 0;
  vat: number = 0;
  @Input() currency: string;

  // PayPal express checkout
  amountPayable: number;
  addScript: boolean = false;
  paypalConfig = {
    env: 'sandbox',
    client: {
      sandbox: env.paypal.clientId,
      production: '',
    },
    commit: true,
    payment: (data: any, actions: any) => {
      return actions.payment.create({
        transactions: [
          { amount: { total: this.amountPayable, currency: this.currency } },
        ],
      });
    },
    onAuthorize: (data: any, actions: any) => {
      return actions.payment.execute().then((payment: any) => {
        this.shoppingCartService.checkoutShoppingCart();
        this.shoppingCartService.changeCheckoutState(true);

        setTimeout(() => {
          this.router.navigate(['/']);
          this.shoppingCartService.changeCheckoutState(false);
          this.shoppingCartService.checkoutFailedChanged(false);
        }, 5000);
      });
    },
  };

  constructor(
    private shoppingCartService: ShoppingCartService,
    private currencyService: CurrencyService,
    private router: Router
  ) {
    if (localStorage.getItem('shopping-cart')) {
      this.reservations = <Reservation[]>(
        JSON.parse(localStorage.getItem('shopping-cart'))
      );
    } else {
      this.reservations = this.shoppingCartService.reservationList;
    }

    this.currency = this.currencyService.getCurrency();
    this.getTotals();
  }

  ngOnChanges(): void {
    this.amountPayable =
      this.currency == 'EUR'
        ? (+Math.round((this.totalExclTax * 1.21) * 100) / 100)
        : (this.getUsdPrice(this.totalExclTax * 1.21));
  }

  ngAfterViewChecked(): void {
    if (!this.addScript) {
      this.addPaypalScript().then(() => {
        paypal.Button.render(this.paypalConfig, '#paypal-checkout-btn');
      });
    }
  }

  addPaypalScript() {
    this.addScript = true;
    return new Promise((resolve, reject) => {
      let scripttagElement = document.createElement('script');
      scripttagElement.src = 'https://www.paypalobjects.com/api/checkout.js';
      scripttagElement.onload = resolve;
      document.body.appendChild(scripttagElement);
    });
  }

  ngOnInit(): void {
    this.reservationsChanged =
      this.shoppingCartService.reservationListChanged$.subscribe({
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

  getUsdPrice(amount: number): number {
    let usdAmount = this.currencyService.convertEuroToUsd(amount);
    return +Math.round(usdAmount * 100) / 100
  }

}
