import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription, take } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { CarService } from 'src/app/services/car.service';
import { CurrencyService } from 'src/app/services/currency.service';

@Component({
  selector: 'app-car-details',
  templateUrl: './car-details.component.html',
  styleUrls: ['./car-details.component.css'],
})
export class CarDetailsComponent implements OnInit {
  car: Car;
  currency: string;
  currencySubscription: Subscription;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private carService: CarService,
    private currencyService: CurrencyService
  ) {
    this.currency = this.currencyService.getCurrency();
  }

  ngOnInit(): void {
    // https://angular-training-guide.rangle.io/routing/child_routes
    this.route.params.subscribe((params) => {
      this.carService
        .getCarById$(params['id'])
        .pipe(take(1))
        .subscribe((car) => {
          let json = JSON.stringify(car);
          this.car = JSON.parse(json);
        });
    });

    this.currencySubscription = this.currencyService.currencyChanged$.subscribe(
      (currency) => (this.currency = currency)
    );
  }

  onReserve() {
    this.router.navigate(['reserve'], { relativeTo: this.route });
  }

  getUsdPrice(): number {
    return this.currencyService.convertEuroToUsd(
      this.car.start_day_price_euro_excl_vat
    );
  }
}
