import { Component, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { CarService } from 'src/app/services/car.service';

@Component({
  selector: 'app-car-reservation',
  templateUrl: './car-reservation.component.html',
  styleUrls: ['./car-reservation.component.css'],
})
export class CarReservationComponent implements OnInit {
  car: Car;
  currentCarSubscription: Subscription;

  constructor(private carService: CarService) {
    this.car = this.carService.getCurrentSelectedCar();
  }

  ngOnInit(): void {
    this.currentCarSubscription = this.carService.currentSelectedCar$.subscribe(
      (currentCar) => (this.car = currentCar)
    );
  }
}
