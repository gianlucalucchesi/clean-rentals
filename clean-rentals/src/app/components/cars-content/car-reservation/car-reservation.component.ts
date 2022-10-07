import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormArray, FormControl, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbCalendar, NgbDate } from '@ng-bootstrap/ng-bootstrap';
import { Subscription, take } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { Location } from 'src/app/models/location.model';
import { ReservationOption } from 'src/app/models/reservation-option.model';
import { Reservation } from 'src/app/models/reservation.model';
import { CarService } from 'src/app/services/car.service';
import { CurrencyService } from 'src/app/services/currency.service';
import { LocationService } from 'src/app/services/location.service';
import { ReservationService } from 'src/app/services/reservation.service';
import { ShoppingCartService } from 'src/app/services/shopping-cart.service';

@Component({
  selector: 'app-car-reservation',
  templateUrl: './car-reservation.component.html',
  styleUrls: ['./car-reservation.component.css'],
})
export class CarReservationComponent implements OnInit, OnDestroy {
  currentCar: Car;
  currentCarSubscription: Subscription;
  reservation: Reservation;
  reservationOptions: ReservationOption[];
  currency: string;
  currencySubscription: Subscription;
  reservationFailedSubscription: Subscription;
  reservationFailed: Boolean = false;
  reservationSuccessSubscription: Subscription;
  reservationSuccess: Boolean = false;
  reservationForm: FormGroup;
  locations: Location[] = [];

  // Date picker
  hoveredDate: NgbDate | null = null;
  fromDate: NgbDate;
  toDate: NgbDate | null = null;

  constructor(
    private carService: CarService,
    private reserveService: ReservationService,
    private router: Router,
    private route: ActivatedRoute,
    public calendar: NgbCalendar,
    private currencyService: CurrencyService,
    private shoppingCartService: ShoppingCartService,
    private locationService: LocationService
  ) {
    this.reservation = new Reservation();
    this.reservation.total_price_euro_excl_vat = 0;
    this.reservation.reservationOptions = [];

    this.reservationForm = new FormGroup({
      selectedOptions: new FormControl({
        selectedOptions: new FormArray([]),
      }),
      location: new FormControl(null),
    });

    this.currentCar = this.carService.getCurrentSelectedCar();
    this.fromDate = calendar.getToday();
    this.currency = currencyService.getCurrency();
    // this.toDate = calendar.getNext(calendar.getToday(), 'd', 7);
  }

  ngOnInit(): void {
    this.currentCarSubscription = this.carService.currentSelectedCar$.subscribe(
      {
        next: (currentCar) => (this.currentCar = currentCar),
      }
    );

    this.currencySubscription = this.currencyService.currencyChanged$.subscribe(
      {
        next: (currency) => {
          this.currency = currency;
          console.log('currency changed')
        },
      }
    );

    this.reservationFailedSubscription =
    this.shoppingCartService.reservationFailedChanged$.subscribe({
      next: (reservationFailed) => {
        this.reservationFailed = reservationFailed;
        this.navigate();
        console.log('reservationFailed changed')
      },
    });

    this.reservationSuccessSubscription =
    this.shoppingCartService.reservationFailedChanged$.subscribe({
      next: (reservationSuccess) => {
        this.reservationSuccess = reservationSuccess;
        this.navigate();
        console.log('reservationSuccess changed')
      },
    });

    this.reserveService
      .getReservationOptions$()
      .pipe(take(1))
      .subscribe({
        next: (options) =>
          (this.reservationOptions = JSON.parse(JSON.stringify(options))),
      });

    this.locationService
      .getLocations$()
      .pipe(take(1))
      .subscribe({
        next: (locations) =>
          (this.locations = JSON.parse(JSON.stringify(locations))),
      });
  }

  ngOnDestroy(): void {
    this.currentCarSubscription.unsubscribe();
    this.currencySubscription.unsubscribe();
    this.reservationFailedSubscription.unsubscribe();
    this.reservationSuccessSubscription.unsubscribe();
  }

  onCheckboxChange(event: any, option: ReservationOption) {
    if (event.target.checked) {
      this.reservation.reservationOptions.push(option);
    } else {
      const index = this.reservation.reservationOptions.indexOf(option);
      this.reservation.reservationOptions.splice(index, 1); // 1 means remove one item only
    }

    this.calculateTotalPrice();
  }

  onDateSelection(date: NgbDate) {
    if (!this.fromDate && !this.toDate) {
      this.fromDate = date;
    } else if (this.fromDate && !this.toDate && date.after(this.fromDate)) {
      this.toDate = date;
    } else {
      this.toDate = null;
      this.fromDate = date;
    }

    this.calculateTotalPrice();
  }

  isHovered(date: NgbDate) {
    return (
      this.fromDate &&
      !this.toDate &&
      this.hoveredDate &&
      date.after(this.fromDate) &&
      date.before(this.hoveredDate)
    );
  }

  isInside(date: NgbDate) {
    return this.toDate && date.after(this.fromDate) && date.before(this.toDate);
  }

  isRange(date: NgbDate) {
    return (
      date.equals(this.fromDate) ||
      (this.toDate && date.equals(this.toDate)) ||
      this.isInside(date) ||
      this.isHovered(date)
    );
  }

  onCancel() {
    this.carService.setCurrentSelectedCar(null);
    this.reserveService.setReserveMode(false);
    this.router.navigate(['../'], { relativeTo: this.route });
  }

  calculateTotalPrice() {
    if (this.fromDate && this.toDate) {
      this.reservation.dateTimeStart = new Date(
        this.fromDate.year,
        this.fromDate.month - 1,
        this.fromDate.day
      );

      this.reservation.dateTimeStop = new Date(
        this.toDate.year,
        this.toDate.month - 1,
        this.toDate.day
      );

      // Milliseconds to days --- +1 to make inclusive
      let days =
        (this.reservation.dateTimeStop.getTime() -
          this.reservation.dateTimeStart.getTime()) /
          (1000 * 3600 * 24) +
        1;

      let optionsPrice = 0;
      for (let option of this.reservation.reservationOptions) {
        optionsPrice += option.day_price_euro_excl_vat;
      }

      let totalOptionsPrice = optionsPrice * days;
      let carPrice = this.currentCar.start_day_price_euro_excl_vat * days;

      this.reservation.total_price_euro_excl_vat = carPrice + totalOptionsPrice;
    }
  }

  onSubmit() {
    let location = this.locations.find(
      (x) => x.name === this.reservationForm.get('location').value
    );

    if (location) {
      this.reservation.location = location;
    } else {
      this.reservation.location = this.locations[0];
    }

    this.reservation.car = this.currentCar;
    this.shoppingCartService.validateReservation(this.reservation);
  }

  navigate() {
    this.router.navigate(['/cars-overview']);
    // this.shoppingCartService.changeReservationSuccess(false);
  }

  getUsdPrice(euroPrice: number): number {
    return this.currencyService.convertEuroToUsd(euroPrice);
  }
}
