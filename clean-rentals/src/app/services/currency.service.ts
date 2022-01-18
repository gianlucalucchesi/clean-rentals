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
      this.currency = localStorage.getItem('currency');
      this.getUsdRate();
    } else {
      this.currency = 'EUR';
      this.getUsdRate();
    }
    this.currencyChanged$.next(this.currency);
  }

  getCurrency() {
    return this.currency;
  }

  getRate() {
    return this.rate;
  }

  setCurrency(currency: string) {
    switch (currency) {
      case 'EUR':
        localStorage.setItem('currency', currency);
        this.currency = currency;
        this.currencyChanged$.next(this.currency);
        break;
      case 'USD':
        localStorage.setItem('currency', currency);
        this.currency = currency;
        this.currencyChanged$.next(this.currency);
        break;
      default:
        localStorage.setItem('currency', 'EUR');
        this.currency = 'EUR';
        this.currencyChanged$.next(this.currency);
    }
  }

  getUsdRate() {
    // Either a uri or uriMatcher is required when configuring the HTTP interceptor.
    this.http.get('https://api.frankfurter.app/latest').subscribe((json) => {
      let obj = JSON.parse(JSON.stringify(json));
      let fx = obj.rates.USD;
      this.rate = fx;
      this.rateChanged$.next(this.rate);
    });

  }
}
