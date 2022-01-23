import { Component, OnDestroy, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription, take } from 'rxjs';
import { CarPage } from 'src/app/models/car-page.model';
import { Car } from 'src/app/models/car.model';
import { CarService } from 'src/app/services/car.service';
import { CurrencyService } from 'src/app/services/currency.service';

@Component({
  selector: 'app-cars-content',
  templateUrl: './cars-content.component.html',
  styleUrls: ['./cars-content.component.css'],
})
export class CarsContentComponent implements OnInit, OnDestroy {
  @Output() cars: CarPage;
  @Output() currency: string;
  currencySubscription: Subscription;
  pageNumber: number = 1;
  pageSize: number = 5;

  constructor(
    private carService: CarService,
    private currencyService: CurrencyService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.currency = this.currencyService.getCurrency();
  }

  ngOnInit(): void {
    this.carService
    .getPaginatedCars$(this.pageNumber, this.pageSize)
    .pipe(take(1))
    .subscribe((cars) => this.handleCars(cars))

    this.currencySubscription = this.currencyService.currencyChanged$.subscribe(
      (currency) => {
        this.currency = currency;
      }
    );
  }

  ngOnDestroy(): void {
    this.currencySubscription.unsubscribe();
  }

  handleCars(rawJson: any) {
    this.cars = JSON.parse(JSON.stringify(rawJson));
  }

  OnSelectCar(selectedCar: Car) {
    this.router.navigate([selectedCar.id], { relativeTo: this.route });
  }

  getNextPage() {
    this.pageNumber++;
    this.getCarsPage();
  }

  getPreviousPage() {
    this.pageNumber--;
    this.getCarsPage();
  }

  getCarsPage() {
    this.cars = null;

    this.carService
    .getPaginatedCars$(this.pageNumber, this.pageSize)
    .pipe(take(1))
    .subscribe((cars) => this.handleCars(cars))
  }

  changePageSize(event: any) {
    // Page number reset because user could ask for 20 cars on page 5 (which doesn't exist) -> empty
    this.pageNumber = 1;
    this.pageSize = event.target.value;
    this.getCarsPage();
  }

}
