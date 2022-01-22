import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CurrencyService {
  private currency: string;
  currencyChanged$ = new Subject<string>();
  private rate: number;
  rateChanged$ = new Subject<number>();

  constructor(private http: HttpClient) {
    if (localStorage.getItem('currency')) {
      this.setCurrency(localStorage.getItem('currency'));
      this.getUsdRate();
    } else {
      this.setCurrency(localStorage.getItem('EUR'));
      this.getUsdRate();
    }
  }

  setCurrency(currency: string) {
    switch (currency) {
      case 'EUR':
        this.handleCurrency(currency);
        break;
      case 'USD':
        this.handleCurrency(currency);
        break;
      default:
        this.handleCurrency('EUR');
    }
  }

  getCurrency() {
    return this.currency;
  }

  getRate() {
    return this.rate;
  }

  handleCurrency(currency: string) {
    localStorage.setItem('currency', currency);

    this.currency = currency;
    this.currencyChanged$.next(this.currency);
  }

  getUsdRate() {
    // Warning: Either a uri or uriMatcher is required when configuring the HTTP interceptor.
    this.http.get('https://api.frankfurter.app/latest').subscribe((json) => {
      let obj = JSON.parse(JSON.stringify(json));
      let fx = obj.rates.USD;
      this.rate = fx;
      this.rateChanged$.next(this.rate);
    });
  }
}
