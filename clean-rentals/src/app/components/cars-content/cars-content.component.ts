import { Component, OnDestroy, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
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
  @Output() currency: string;
  currencySubscription: Subscription;
  fxRateSubscription: Subscription;

  constructor(
    private carService: CarService,
    private currencyService: CurrencyService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.currency = this.currencyService.getCurrency();
    this.fxRate = this.currencyService.getRate();
  }

  ngOnInit(): void {
    this.carService
      .getCars$()
      .pipe(take(1))
      .subscribe((cars) => this.handleCars(cars));

    this.currencySubscription =
      this.currencyService.currencyChanged$.subscribe((currency) => {
        this.currency = currency;
      });

    this.fxRateSubscription = this.currencyService.rateChanged$.subscribe(
      (rate) => (this.fxRate = rate)
    );
  }

  ngOnDestroy(): void {
    this.fxRateSubscription.unsubscribe();
    this.currencySubscription.unsubscribe();
  }

  handleCars(rawJson: any) {
    this.cars = JSON.parse(JSON.stringify(rawJson));
  }

  OnSelectCar(selectedCar: Car){
    this.router.navigate([selectedCar.id], { relativeTo: this.route });
  }
}
