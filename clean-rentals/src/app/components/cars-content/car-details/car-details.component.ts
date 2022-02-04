import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, NavigationStart, Router } from '@angular/router';
import { Subscription, take } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { CarService } from 'src/app/services/car.service';
import { CurrencyService } from 'src/app/services/currency.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-car-details',
  templateUrl: './car-details.component.html',
  styleUrls: ['./car-details.component.css'],
})
export class CarDetailsComponent implements OnInit, OnDestroy {
  car: Car;
  currency: string;
  currencySubscription: Subscription;
  reserveMode = false;
  reserveModeSubscription: Subscription;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private carService: CarService,
    private currencyService: CurrencyService,
    private reserveService: ReservationService
  ) {
    this.currency = this.currencyService.getCurrency();

    // Detect is back navigator button is pressed
    // If reserveMode not reset after back button pressed -> button stays hidden
    this.router.events.subscribe((event) => {
      if (
        event instanceof NavigationStart &&
        event.navigationTrigger === 'popstate'
      ) {
        this.reserveMode = false;
      }
    });
  }

  ngOnInit(): void {
    // https://angular-training-guide.rangle.io/routing/child_routes
    this.route.params.subscribe((params) => {
      this.carService
        .getCarById$(params['id'])
        .pipe(take(1))
        .subscribe({
          next: (car) => {
            let json = JSON.stringify(car);
            this.car = JSON.parse(json);
          },
        });
    });

    this.currencySubscription = this.currencyService.currencyChanged$.subscribe(
      {
        next: (currency) => (this.currency = currency),
      }
    );

    this.reserveModeSubscription =
      this.reserveService.reserveModeChanged$.subscribe({
        next: (mode) => (this.reserveMode = mode),
      });
  }

  ngOnDestroy(): void {
    this.reserveModeSubscription.unsubscribe();
    this.currencySubscription.unsubscribe();
  }

  onReserve() {
    this.carService.setCurrentSelectedCar(this.car);
    this.reserveService.setReserveMode(true);
    this.router.navigate(['reserve'], { relativeTo: this.route });
  }

  getUsdPrice(): number {
    return this.currencyService.convertEuroToUsd(
      this.car.start_day_price_euro_excl_vat
    );
  }
}
