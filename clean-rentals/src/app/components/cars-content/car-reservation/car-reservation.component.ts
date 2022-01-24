import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { CarService } from 'src/app/services/car.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-car-reservation',
  templateUrl: './car-reservation.component.html',
  styleUrls: ['./car-reservation.component.css'],
})
export class CarReservationComponent implements OnInit {
  car: Car;
  currentCarSubscription: Subscription;

  constructor(
    private carService: CarService,
    private reserveService: ReservationService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.car = this.carService.getCurrentSelectedCar();
  }

  ngOnInit(): void {
    this.currentCarSubscription = this.carService.currentSelectedCar$.subscribe(
      (currentCar) => (this.car = currentCar)
    );
  }

  onCancel() {
    this.carService.setCurrentSelectedCar(null);
    this.reserveService.setReserveMode(false);
    this.router.navigate(['../'], { relativeTo: this.route });
  }

  onSubmit() {

  }
}
