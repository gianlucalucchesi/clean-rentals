import { DOCUMENT } from '@angular/common';
import { Component, Inject, OnInit } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { faUser } from '@fortawesome/free-regular-svg-icons';
import {
  faCarAlt,
  faDollarSign,
  faEuroSign,
  faPowerOff,
  faServer,
  faShoppingCart,
} from '@fortawesome/free-solid-svg-icons';
import { Subscription } from 'rxjs';
import { ClientService } from 'src/app/services/client.service';
import { CurrencyService } from 'src/app/services/currency.service';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css'],
})
export class NavBarComponent implements OnInit {
  // Navbar layout logic
  isCollapsed: boolean = true;

  // Font Awesome icons
  faUser = faUser;
  faPowerOff = faPowerOff;
  faCarAlt = faCarAlt;
  faDollarSign = faDollarSign;
  faEuroSign = faEuroSign;
  faShoppingCart = faShoppingCart;
  faServer = faServer;

  currencySubscription: Subscription;
  currency: string;
  rateSubscription: Subscription;
  rateUSD: number;
  rateEUR: number;
  // tokenSubs: Subscription;

  constructor(
    public currencyService: CurrencyService,
    private clientService: ClientService,
    public auth: AuthService,
    @Inject(DOCUMENT) private doc: Document
  ) {
    this.getCurrency();
    currencyService.getRate();
  }

  ngOnInit(): void {
    // this.tokenSubs = this.auth.isAuthenticated$.subscribe(x => {
    //   this.auth.getAccessTokenSilently().subscribe((token) => {
    //     console.log(token);
    //   })
    // })
    this.currencySubscription = this.currencyService.currencyChanged$.subscribe(
      (currency) => {
        this.currency = currency;
      }
    );
    this.rateSubscription = this.currencyService.rateChanged$.subscribe(
      (rate) => {
        this.rateUSD = 1 / rate;
        this.rateEUR = rate;
      }
    );
  }

  loginWithRedirect() {
    this.auth.loginWithRedirect();
  }

  logout() {
    this.auth.logout({ returnTo: this.doc.location.origin });
  }

  private getCurrency() {
    if (localStorage.getItem('currency')) {
      this.currency = localStorage.getItem('currency');
    } else {
      this.currency = this.currencyService.getCurrency();
      localStorage.setItem('currency', this.currency);
    }
  }

  onChangeCurrency(currency: string) {
    this.currencyService.setCurrency(currency);
  }
}
