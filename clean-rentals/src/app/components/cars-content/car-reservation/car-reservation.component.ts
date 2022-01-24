import { Component, OnChanges, OnDestroy, OnInit, SimpleChanges } from '@angular/core';
import { FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import {
  NgbCalendar,
  NgbDate,
  NgbDateStruct,
} from '@ng-bootstrap/ng-bootstrap';
import { Subscription } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { ReservationOption } from 'src/app/models/reservation-option.model';
import { Reservation } from 'src/app/models/reservation.model';
import { CarService } from 'src/app/services/car.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-car-reservation',
  templateUrl: './car-reservation.component.html',
  styleUrls: ['./car-reservation.component.css'],
})
export class CarReservationComponent implements OnInit, OnDestroy {
  car: Car;
  currentCarSubscription: Subscription;
  reservation: Reservation;
  reservationOptions: ReservationOption[];

  // Date picker
  hoveredDate: NgbDate | null = null;
  fromDate: NgbDate;
  toDate: NgbDate | null = null;

  constructor(
    private carService: CarService,
    private reserveService: ReservationService,
    private router: Router,
    private route: ActivatedRoute,
    calendar: NgbCalendar
  ) {
    this.reservation = new Reservation();
    this.car = this.carService.getCurrentSelectedCar();
    this.fromDate = calendar.getToday();
    // this.toDate = calendar.getNext(calendar.getToday(), 'd', 7);
  }

  ngOnInit(): void {
    this.currentCarSubscription = this.carService.currentSelectedCar$.subscribe(
      (currentCar) => (this.car = currentCar)
    );
  }

  ngOnDestroy(): void {
    this.currentCarSubscription.unsubscribe();
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

    this.calculatePrice();
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

  calculatePrice(): number {
    let dateStart = new Date(this.fromDate.year, this.fromDate.month - 1, this.fromDate.day);
    let dateStop = new Date(this.toDate.year, this.toDate.month - 1, this.toDate.day);
    let days = (dateStop.getTime() - dateStart.getTime()) / (1000 * 3600 * 24); // Milliseconds to days

    let carPrice = this.car.start_day_price_euro_excl_vat * days;
    let optionsPrice = 0; // TODO

    throw new Error('Method not implemented.');

    return carPrice + optionsPrice;
  }

  onSubmit() {
    this.reservation.dateTimeStart = new Date(this.fromDate.year, this.fromDate.month - 1, this.fromDate.day);
    this.reservation.dateTimeStop = new Date(this.toDate.year, this.toDate.month - 1, this.toDate.day);

    console.log(this.reservation)
  }
}
