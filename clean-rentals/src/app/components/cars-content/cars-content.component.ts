import { Component, OnDestroy, OnInit, Output } from '@angular/core';
import { Subscription, take } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { CarService } from 'src/app/services/car.service';
import { CurrencyService } from 'src/app/services/currency.service';

@Component({
  selector: 'app-cars-content',
  templateUrl: './cars-content.component.html',
  styleUrls: ['./cars-content.component.css'],
})
export class CarsContentComponent implements OnInit, OnDestroy {
  @Output() cars: Car[];
  @Output() fxRate: number;
  @Output() currencyIcon: string;
  currencySubscription: Subscription;
  rateSubscription: Subscription;

  constructor(
    private carService: CarService,
    private currencyService: CurrencyService
  ) {
    this.currencyIcon = this.currencyService.getCurrencyIcon();
    this.fxRate = this.currencyService.getRate();
  }

  ngOnInit(): void {
    this.carService
      .getCars$()
      .pipe(take(1))
      .subscribe((cars) => this.handleCars(cars));

    this.currencySubscription = this.currencyService.currencyIconChanged$.subscribe((icon) => {
      this.currencyIcon = icon;
    });

    this.rateSubscription = this.currencyService.rateChanged$.subscribe(
      (rate) => (this.fxRate = rate)
    );
  }

  ngOnDestroy(): void {
    this.rateSubscription.unsubscribe();
    this.currencySubscription.unsubscribe();
  }

  handleCars(rawJson: any) {
    this.cars = JSON.parse(JSON.stringify(rawJson));
  }
}
